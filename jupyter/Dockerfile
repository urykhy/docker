FROM debian:bookworm
ARG APT_PROXY
ARG S_PROXY
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN echo "deb http://mirror.yandex.ru/debian bookworm main non-free contrib" > /etc/apt/sources.list.d/docker.list \
 && apt-get update                                                                                              \
 && apt-get -y --no-install-recommends install python3-pip python3-setuptools  \
		   wget libcupti-dev libgomp1                                          \
		   nvidia-legacy-check nvidia-support glx-alternative-nvidia           \
		   nvidia-cuda-dev nvidia-alternative libnvidia-ptxjitcompiler1        \
		   nvidia-cuda-toolkit nvidia-smi libnvidia-ml1                        \
		   python3-protobuf                                                    \
 && rm -rf /var/lib/apt/lists/* /usr/lib/python3.11/EXTERNALLY-MANAGED

# 8.6.0 required by tensorflow
RUN http_proxy=${S_PROXY} wget http://developer.download.nvidia.com/compute/redist/cudnn/v8.6.0/local_installers/11.8/cudnn-local-repo-debian11-8.6.0.163_1.0-1_amd64.deb \
 && dpkg -i cudnn-local-repo-debian11-8.6.0.163_1.0-1_amd64.deb                               \
 && dpkg -i /var/cudnn-local-repo-debian11-8.6.0.163/libcudnn8_8.6.0.163-1+cuda11.8_amd64.deb \
 && dpkg -r cudnn-local-repo-debian11-8.6.0.163                                               \
 && rm cudnn-local-repo-debian11-8.6.0.163_1.0-1_amd64.deb
RUN pip3 install tensorflow==2.12.0 keras==2.12.0 jupyter && rm -rf /root/.cache
RUN ln -s /usr/lib/cuda /usr/local/cuda

# last steps
RUN mkdir /work
WORKDIR /work
ADD jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
EXPOSE 8888
