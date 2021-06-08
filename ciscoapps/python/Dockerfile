FROM centos 
# THis instruction will automatically pull docker image of centos 
# from Docker hub if not present in Docker host 
MAINTAINER  ashutoshh@linux.com
# optional field these days but info about Image creator 
RUN  yum install python3 -y
#  Centos Base Os having Yum as software Installer 
# RUN is giving a shell for short time 
RUN mkdir  /mydata
COPY hello.py  /mydata/hello.py 
# copy data from docker client to Docker ENgine during build process
#  the location of data and dockerfile must be same 
CMD ["python3","/mydata/hello.py"]
# WIll be used to set by default parent process for this image
# and that can be override during container creation time 