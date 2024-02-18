FROM debian:11

ARG APT_PROXY
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN    apt-get update \
    && apt-get -y install eatmydata \
    && eatmydata apt-get -y --no-install-recommends install libcairo2-dev libgirepository1.0-dev python3-pip python3-setuptools python3-dev \
    && eatmydata pip install --no-cache-dir etna etna[torch] etna[prophet] etna[wandb] etna[classification] etna[statsforecast] pycairo pygobject allure-pytest pytest tabulate \
    && eatmydata apt-get remove -y libcairo2-dev libgirepository1.0-dev \
    && eatmydata apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV MPLCONFIGDIR /tmp
WORKDIR /data

ARG USER_NAME=ury
ARG USER_UID=1000
ARG USER_GID=100
RUN useradd --uid $USER_UID --gid $USER_GID -m $USER_NAME
USER $USER_NAME
