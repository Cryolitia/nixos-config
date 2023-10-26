{ pkgs }:

rec {
  cuda-common-redist = with pkgs.cudaPackages; [
    cuda_cccl # cub/cub.cuh
    libcublas # cublas_v2.h
    libcurand # curand.h
    libcusparse # cusparse.h
    libcufft # cufft.h
    cudnn # cudnn.h
  ];

  cuda-native-redist = with pkgs.cudaPackages; [
      cuda_cudart # cuda_runtime.h cuda_runtime_api.h
      cuda_nvcc
    ] ++ cuda-common-redist;

  cuda-redist = pkgs.symlinkJoin {
    name = "cuda-redist-${pkgs.cudaPackages.cudaVersion}";
    paths = cuda-common-redist;
  };
}
