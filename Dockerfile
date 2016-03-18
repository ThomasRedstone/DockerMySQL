#Dockerfile for mysql 5.4
FROM thomasredstone/base
MAINTAINER thomas@redstone.me.uk
ENV CACHED_FLAG 1
ENV DEBIAN_FRONTEND noninteractive 

RUN apt-get update -qq
RUN apt-get -y upgrade
RUN apt-get -y install mysql-client mysql-server pwgen

RUN mkdir /var/run/mysqld/ && chmod 777 /var/run/mysqld/

RUN mysql_install_db -u mysql
ADD conf/my.cnf /etc/mysql/conf.d/my-orig.cnf

#binding all interfaces
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

ADD startdb.sh /startdb.sh

# Set the environment variables
ENV DB example
ENV DBUSER example
ENV DBPASS 123

ENTRYPOINT [ "/bin/bash","/startdb.sh" ]

EXPOSE 3306
