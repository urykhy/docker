FROM debian:11

# cuDNN
ENV cuDNN=cudnn-11.4-linux-x64-v8.2.4.15.tgz
ADD ${cuDNN} /
RUN    mv /cuda/include/* /usr/include \
    && mv /cuda/lib64/*   /usr/lib/    \
    && rm -rf /cuda

# python and nvidia libs
RUN    echo "deb http://deb.debian.org/debian testing main non-free contrib" >> /etc/apt/sources.list.d/docker.list \
    && apt-get update                                                                                               \
    && apt-get -y --no-install-recommends install python3-pip python3-setuptools                                    \
               wget libcupti-dev libgomp1                                                                           \
               nvidia-legacy-check nvidia-support glx-alternative-nvidia                                            \
               nvidia-cuda-dev nvidia-alternative libnvidia-ptxjitcompiler1                                         \
               nvidia-cuda-toolkit nvidia-smi libnvidia-ml1                                                         \
    && rm -rf /var/lib/apt/lists/*

# python parts
RUN    pip3 install tensorflow-gpu keras jupyter \
    && rm -rf /root/.cache

# last steps
RUN mkdir /work
WORKDIR /work
ADD jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
EXPOSE 8888