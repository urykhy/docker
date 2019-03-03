FROM centos:7

RUN yum -y install wget
RUN wget ftp://10.103.10.3/common/tmp/oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm -O /oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm  \
 && wget ftp://10.103.10.3/common/tmp/oracle-database-xe-18c-1.0-1.x86_64.rpm -O /oracle-database-xe-18c-1.0-1.x86_64.rpm \
 && yum -y localinstall /*.rpm > /tmp/XEsilentinstall                                                                     \
 && rm /*.rpm

USER oracle
#VOLUME /opt/oracle/oradata/
ENV ORACLE_SID=XE
ENV ORACLE_HOME=/opt/oracle/product/18c/dbhomeXE
ADD configure.sh /configure.sh
RUN ./configure.sh

ADD entry.sh /entry.sh
CMD ["/entry.sh"]

EXPOSE 1521 5500
