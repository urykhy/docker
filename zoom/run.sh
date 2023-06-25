docker run --rm -it --privileged --net=host \
    -e DISPLAY=$DISPLAY                     \
    -e QT_GRAPHICSSYSTEM="native"           \
    -e PULSE_SERVER=unix:/run/user/1000/pulse/native \
    -e QT_X11_NO_MITSHM=1               \
    -v /tmp/.X11-unix:/tmp/.X11-unix    \
    -v /etc/machine-id:/etc/machine-id  \
    -v /dev/dri:/dev/dri                \
    -v /dev/video0:/dev/video0          \
    -v /dev/video1:/dev/video1          \
    --volume=/dev/shm:/dev/shm          \
    --volume=/run/user/1000/pulse:/run/user/1000/pulse  \
    --volume=`pwd`/data:/home/user                      \
    --name zoom     \
    urykhy/zoom     \
    /opt/zoom/ZoomLauncher --no-sandbox "$@"
