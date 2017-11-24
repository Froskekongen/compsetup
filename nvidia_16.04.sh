NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

#CUDA_VERSION=9.0.176
#CUDNN_VERSION=7.0.3.11
#apt-get update && apt-get install -y --no-install-recommends \
#        cuda-nvrtc-$CUDA_PKG_VERSION \
#        cuda-nvgraph-$CUDA_PKG_VERSION \
#        cuda-cusolver-$CUDA_PKG_VERSION \
#        cuda-cublas-8-0=8.0.61.2-1 \
#        cuda-cufft-$CUDA_PKG_VERSION \
#        cuda-curand-$CUDA_PKG_VERSION \
#        cuda-cusparse-$CUDA_PKG_VERSION \
#        cuda-npp-$CUDA_PKG_VERSION \
#        cuda-cudart-$CUDA_PKG_VERSION \
#        libcudnn6=$CUDNN_VERSION-1+cuda8.0 && \
#    ln -s cuda-9.0 /usr/local/cuda

#echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf && \
#    ldconfig
