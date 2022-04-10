function k8s_upstream(t) {
    var up = Array('node1.kubernets.docker:30080', 'node2.kubernets.docker:30080');
    var s = up[Math.floor(Math.random() * up.length)];
    return 'http://' + s;
}

export default { k8s_upstream }