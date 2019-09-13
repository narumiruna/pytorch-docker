FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

ARG PYTHON_VERSION=3.6
ARG TORCH_VERSION=v1.2.0
ARG TORCHVISION_VERSION=v0.4.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    git \
    libjpeg-dev \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o ~/miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda install -y python=${PYTHON_VERSION} numpy pyyaml scipy ipython mkl mkl-include ninja cython typing \
    && conda install -y -c pytorch magma-cuda100 \
    && conda clean -ya

RUN TORCH_CUDA_ARCH_LIST="3.5 5.2 6.0 6.1 7.0+PTX" \
    TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
    pip install -v -U git+https://github.com/pytorch/pytorch.git@${TORCH_VERSION}#egg=torch \
    && pip install -v -U git+https://github.com/pytorch/vision.git@${TORCHVISION_VERSION}#egg=torchvision \
    && rm -rf ~/.cache/pip

WORKDIR /workspace
RUN chmod -R a+w .
