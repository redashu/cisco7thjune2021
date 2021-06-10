FROM centos
#MAINTAINER  ashutoshh@linux.com
LABEL  "author.name"="ashutoshh"
LABEL  "author.email"="ashutoshh@linux.com"
RUN yum install httpd -y
COPY  .  /var/www/html/
# all data of current directory where Dockerfile is present 
# copy that to docker engine during image build time 
EXPOSE 80
# optional keyword these days but to tell your default port number 
# during container creation time only 
CMD  ["httpd","-DFOREGROUND"]
# this script is to start httpd webserver 