FROM urykhy/mysql-common

EXPOSE 3306
ADD my.cnf /etc/my.cnf
ADD entry.sh /usr/bin/
ENTRYPOINT ["/usr/bin/entry.sh"]
