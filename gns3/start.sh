
docker run -it --privileged --net=host -e LIBGL_ALWAYS_INDIRECT=1 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /etc/machine-id:/etc/machine-id -v gns3:/home/user --name gns3 urykhy/gns3
