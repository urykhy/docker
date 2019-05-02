FROM tensorflow/tensorflow:latest-jupyter
# tensorflow/tensorflow:latest-gpu-jupyter

RUN mkdir /work
WORKDIR /work

RUN pip install keras
ADD jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888
