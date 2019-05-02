FROM debian:stretch

# cuDNN
ENV cuDNN=cudnn-9.0-linux-x64-v7.5.1.10.tgz
ADD ${cuDNN} /
RUN    mv /cuda/include/* /usr/include \
    && mv /cuda/lib64/*   /usr/lib/    \
    && rm -rf /cuda

# nvidia toolkit must be 9.0 version (match cuDNN)
ENV BASE=https://snapshot.debian.org/archive/debian/20180112T095910Z/pool/non-free/n/nvidia-cuda-toolkit
ENV REL=9.0_9.0.176-2_amd64.deb

# libcuda version must be in sync with host driver version
ENV BASEx=https://snapshot.debian.org/archive/debian/20190210T090530Z/pool/non-free/n/nvidia-graphics-drivers
ENV RELx=390.87-8~deb9u1_amd64.deb

# python and nvidia libs
RUN    echo "deb http://deb.debian.org/debian stretch-backports main contrib non-free" >> /etc/apt/sources.list.d/docker.list \
    && echo "deb http://deb.debian.org/debian stretch contrib non-free"                >> /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get -y --no-install-recommends install python3-pip python3-setuptools wget libcupti-dev libgomp1 nvidia-legacy-check nvidia-support glx-alternative-nvidia \
    && wget ${BASE}/libcublas${REL}   \
    && wget ${BASE}/libcusolver${REL} \
    && wget ${BASE}/libcudart${REL}   \
    && wget ${BASE}/libcufft${REL}    \
    && wget ${BASE}/libcurand${REL}   \
    && wget ${BASEx}/libcuda1_${RELx} \
    && wget ${BASEx}/nvidia-alternative_${RELx} \
    && wget ${BASEx}/libnvidia-fatbinaryloader_${RELx} \
    && wget ${BASEx}/libnvidia-ptxjitcompiler1_${RELx} \
    && wget ${BASEx}/nvidia-smi_${RELx} \
    && wget ${BASEx}/libnvidia-ml1_${RELx} \
    && dpkg -i *.deb && rm *.deb      \
    && rm -rf /var/lib/apt/lists/* 

# python parts
# TF 1.12 latest version with cuda 9.0, cudnn 7
RUN    pip3 install tensorflow-gpu==1.12.2 keras jupyter \
    && rm -rf /root/.cache

# last steps
RUN mkdir /work
WORKDIR /work
ADD jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
EXPOSE 8888