#include <cassert>
#include <filesystem>
#include <fstream>
#include <iostream>
#include "cpu.h"
#include "overlay_params.h"
#undef MAX
#define MANGOHUD_LEGACY
#include "../mangohud-next/server/metrics/gpu/msm/dpu.hpp"
#undef GPU

namespace testfs = std::filesystem;
static auto parameters = std::make_shared<overlay_params>();
std::shared_ptr<overlay_params> get_params() { return parameters; }

static void write(const std::string& path, const std::string& value) {
    testfs::create_directories(testfs::path(path).parent_path());
    std::ofstream(path) << value << '\n';
}
static void reset() {
    testfs::remove_all("fixture");
    testfs::create_directories("fixture/sys/class/hwmon");
    parameters->cpu_custom_temp_sensor.clear();
}
static std::string hwmon(int id, const std::string& name, const std::string& value) {
    const std::string path = "fixture/sys/class/hwmon/hwmon" + std::to_string(id);
    write(path + "/name", name);
    write(path + "/temp1_input", value);
    return path;
}
static std::string zone(int id, const std::string& type, const std::string& value) {
    const std::string path = "fixture/sys/class/thermal/thermal_zone" + std::to_string(id);
    write(path + "/type", type);
    write(path + "/temp", value);
    return path;
}
static void cpu_temperature(CPUStats& cpu, int expected) {
    assert(cpu.GetCpuFile());
    int actual = 123;
    assert(cpu.ReadcpuTempFile(actual));
    assert(actual == expected);
}
static void cpu_tests() {
    reset();
    const auto first = hwmon(0, "cpu_0_0_0_thermal", "41750");
    write(first + "/temp2_input", "65000");
    const auto second = hwmon(1, "cpu_1_1_1_thermal", "88000");
    const auto fallback = zone(0, "cpuss-1-0-thermal", "91000");
    hwmon(2, "cpuss0_0", "unavailable");
    hwmon(3, "gpuss0_thermal", "99000");
    hwmon(4, "battery", "100000");
    CPUStats cpu;
    cpu_temperature(cpu, 91); // maximum, not mean or first directory entry
    write(fallback + "/temp", "-12000");
    write(first + "/temp1_input", "-3500");
    write(first + "/temp2_input", "-7000");
    write(second + "/temp1_input", "-15000");
    cpu_temperature(cpu, -3); // reread the same object, including negative values
    write(first + "/temp1_fault", "1");
    cpu_temperature(cpu, -7);

    reset();
    hwmon(0, "cpu0_thermal", "99000");
    hwmon(1, "custom_chip", "37000");
    parameters->cpu_custom_temp_sensor = {{"hwmon_name", "custom_chip"}, {"hwmon_input", "temp1"}};
    CPUStats custom;
    cpu_temperature(custom, 37);
    parameters->cpu_custom_temp_sensor["hwmon_name"] = "missing";
    CPUStats missing_custom;
    assert(!missing_custom.GetCpuFile()); // honor explicit configuration

    reset();
    hwmon(0, "cpu0_thermal", "99000");
    const auto package = hwmon(1, "coretemp", "65000");
    write(package + "/temp1_label", "Package id 0");
    CPUStats vendor;
    cpu_temperature(vendor, 65);

    reset();
    const auto invalid = hwmon(0, "cpu0_thermal", "99000broken");
    const auto valid = zone(1, "cpu1-top-thermal", "76000");
    CPUStats recover;
    cpu_temperature(recover, 76);
    testfs::remove(valid + "/temp");
    int temperature;
    assert(!recover.ReadcpuTempFile(temperature));
    write(invalid + "/temp1_input", "0");
    cpu_temperature(recover, 0);
    write(valid + "/temp", "81000");
    cpu_temperature(recover, 81);
}

static void gpu_tests() {
    reset();
    const auto first = hwmon(0, "gpuss0_thermal", "61000");
    const auto second = hwmon(1, "gpuss_1_thermal", "88000");
    const auto third = zone(0, "gpuss-2-thermal", "97000");
    hwmon(2, "gpuss3_thermal", "invalid");
    zone(1, "cpu-0-0-0-thermal", "120000");
    zone(2, "ddr-thermal", "110000");
    zone(3, "piano-skin", "125000");
    MSM_DPU gpu("renderD128", "", 0, 0);
    assert(gpu.get_temperature() == 97);
    assert(gpu.get_junction_temperature() == 97);
    assert(gpu.get_memory_temp() == 110); // separate metric
    write(third + "/temp", "bad");
    assert(gpu.get_temperature() == 88);
    write(second + "/temp1_fault", "1");
    assert(gpu.get_temperature() == 61);
    write(first + "/temp1_input", "-3500");
    assert(gpu.get_temperature() == -4);
    testfs::remove(first + "/temp1_input");
    assert(gpu.get_temperature() == 0); // backend's unavailable convention
    write(first + "/temp1_input", "79000");
    assert(gpu.get_temperature() == 79);

    reset();
    const auto aggregate = hwmon(0, "gpu", "60000");
    write(aggregate + "/temp2_input", "115000"); // preserve the dedicated GPU channel
    hwmon(1, "gpuss7_thermal", "90000");
    MSM_DPU dedicated("renderD128", "", 0, 0);
    assert(dedicated.get_temperature() == 60);
    assert(dedicated.get_junction_temperature() == 90);
    write(aggregate + "/temp1_input", "invalid");
    assert(dedicated.get_temperature() == 90);
    write(aggregate + "/temp1_input", "0");
    assert(dedicated.get_temperature() == 0); // valid zero must not trigger fallback

    reset();
    hwmon(0, "gpu", "99000");
    const std::string local = "fixture/sys/class/drm/renderD128/device/hwmon/hwmon9";
    write(local + "/name", "gpu");
    write(local + "/temp1_input", "52000");
    MSM_DPU scoped("renderD128", "", 0, 0);
    assert(scoped.get_temperature() == 52);

    reset();
    testfs::remove_all("fixture");
    CPUStats missing;
    assert(!missing.GetCpuFile());
    MSM_DPU absent("renderD128", "", 0, 0);
    assert(absent.get_temperature() == 0);
    assert(absent.get_junction_temperature() == 0);
}

int main() {
    cpu_tests();
    gpu_tests();
    std::cout << "CPU/GPU thermal tests passed: maximum, ABI fallback, precedence, isolation, errors and recovery\n";
}
