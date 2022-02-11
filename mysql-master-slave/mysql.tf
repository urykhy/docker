provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_volume" "mysql-master" {
  name = "mysql-master"
}
resource "docker_volume" "mysql-slave" {
  name = "mysql-slave"
}

resource "docker_image" "mysql" {
  name = "mysql:8.0"
}

resource "docker_container" "mysql-master" {
  name     = "mysql-master"
  hostname = "mysql-master"
  image    = docker_image.mysql.latest
  command  = ["--server-id=1", "--log-bin=mysql-bin", "--binlog-format=ROW", "--gtid-mode=ON", "--enforce-gtid-consistency", "--performance-schema-instrument=statement/%=ON", "--performance-schema-consumer-statements-digest=ON", "--innodb-monitor-enable=ALL"]
  env      = [
    "MYSQL_ROOT_PASSWORD=root"
  ]
  volumes {
    volume_name = docker_volume.mysql-master.name
    container_path = "/var/lib/mysql"
  }
  log_opts = {
    max-size = "50m"
    max-file = "5"
  }
}

resource "docker_container" "mysql-slave" {
  name      = "mysql-slave"
  hostname  = "mysql-slave"
  image     = docker_image.mysql.latest
  command   = ["--server-id=2", "--log-bin=mysql-bin", "--binlog-format=ROW", "--gtid-mode=ON", "--enforce-gtid-consistency", "--log-slave-updates", "--read-only"]
  env       = [
    "MYSQL_ROOT_PASSWORD=root"
  ]
  volumes {
    volume_name = docker_volume.mysql-slave.name
    container_path = "/var/lib/mysql"
  }
  log_opts = {
    max-size = "50m"
    max-file = "5"
  }
}

provider "mysql" {
  endpoint = docker_container.mysql-master.hostname
  username = "root"
  password = "root"
}

resource "mysql_user" "user" {
  user               = "user"
  host               = "%"
  plaintext_password = ""
}

resource "mysql_grant" "master_user_grants" {
  user       = mysql_user.user.user
  host       = mysql_user.user.host
  database   = "*"
  privileges = ["CREATE","INSERT","SELECT","UPDATE","DELETE","DROP","INDEX","PROCESS"]
}

resource "mysql_user" "slave" {
  user               = "slave"
  host               = "%"
  plaintext_password = "slave"
}

resource "mysql_grant" "master_slave_grants" {
  user       = mysql_user.slave.user
  host       = mysql_user.slave.host
  database   = "*"
  privileges = ["REPLICATION SLAVE"]
}

resource "null_resource" "start_slave" {
  provisioner "local-exec" {
    command = "mysql -proot -h \"${docker_container.mysql-slave.ip_address}\" -e \"CHANGE MASTER TO MASTER_HOST='mysql-master', MASTER_PORT=3306, MASTER_USER='${mysql_user.slave.user}', MASTER_PASSWORD='slave', MASTER_AUTO_POSITION=1, MASTER_SSL=1; START SLAVE USER='${mysql_user.slave.user}' PASSWORD='slave'\""
  }
}

output "master" {
  value = docker_container.mysql-master.network_data
}
output "slave" {
  value = docker_container.mysql-slave.network_data
}
