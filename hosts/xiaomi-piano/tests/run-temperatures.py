"""Exercise actual CPUStats/MSM_DPU methods against an isolated sysfs fixture."""
import json
import shlex
import shutil
import subprocess
import sys
from pathlib import Path

entries = json.loads(Path("compile_commands.json").read_text())
cpu = next(item for item in entries if item["file"].endswith("/src/cpu.cpp"))
root = Path(cpu["file"]).resolve().parent.parent
# Change only sysfs roots in test translation units; retain production code/flags.
fixture_source = Path.cwd() / "temperature-fixture-source"
for directory in ("src", "mangohud-next"):
    shutil.copytree(root / directory, fixture_source / directory)
header = fixture_source / "src/thermal_sensors.h"
header.write_text(header.read_text().replace('"/sys/', '"fixture/sys/'))
paths = [
    "src/cpu.cpp", "src/file_utils.cpp",
    "mangohud-next/server/metrics/gpu/msm/dpu.cpp",
    "mangohud-next/server/metrics/gpu/gpu.cpp",
    "mangohud-next/server/metrics/fdinfo.cpp",
]

def flags(entry):
    command = entry.get("arguments") or shlex.split(entry["command"])
    result = []
    index = 0
    while index < len(command):
        item = command[index]
        if item in ("-o", "-MF", "-MQ", "-MT"):
            index += 2
            continue
        if item not in ("-c", "-MD", "-MMD", entry["file"]):
            result.append(item)
        index += 1
    return result + ["-I" + str(fixture_source / "mangohud-next/server/metrics"),
                     "-UNDEBUG", "-ffunction-sections", "-fdata-sections"]

objects = []
for number, path in enumerate(paths + ["test"]):
    entry = cpu if path == "test" else next(item for item in entries if Path(item["file"]).resolve() == root / path)
    source = fixture_source / "src/temperature-check.cpp" if path == "test" else fixture_source / path
    test_source = source.with_name(source.stem + "-fixture.cpp")
    text = Path(sys.argv[1]).read_text() if path == "test" else source.read_text()
    test_source.write_text(text.replace('"/sys/', '"fixture/sys/'))
    output = f"temperature-check-{number}.o"
    subprocess.run(flags(entry) + ["-c", str(test_source), "-o", output], check=True)
    objects.append(output)
libs = shlex.split(subprocess.check_output(["pkg-config", "--libs", "spdlog"], text=True))
compiler = flags(cpu)[0]
subprocess.run([compiler, *objects, *libs, "-pthread", "-Wl,--gc-sections", "-o", "temperature-check"], check=True)
subprocess.run(["./temperature-check"], check=True)
