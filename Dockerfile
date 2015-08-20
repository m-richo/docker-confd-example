FROM centos:6
MAINTAINER Michael Richardson

RUN yum update -y && yum clean all

ADD files/nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum install -y nginx && \
yum clean all && \
echo -e "\ndaemon off;" >> /etc/nginx/nginx.conf && \
rm /etc/nginx/conf.d/*

ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/local/bin/confd
ADD files/start.sh /start.sh
RUN chmod +x /usr/local/bin/confd /start.sh
ADD files/confd /etc/confd

EXPOSE 80
CMD ["/start.sh"]
