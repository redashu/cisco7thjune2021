FROM openjdk 
# From Dockerhub A pre-installed java based Image
MAINTAINER ashutoshh@linux.com 
# Image Designer INFO 
RUN mkdir /codes
#ADD https://raw.githubusercontent.com/redashu/javaLang/main/test.java /codes/
ADD hello.java /codes/
# COPY and ADD both are same 
# they can take data from Localhost where Dockerfile is present
# ADD can also take data from URL but COPY can't 
WORKDIR /codes
# WORKDIR is to change directory during image build time
# its like cd command in windows / linux / mac 
RUN javac hello.java 
# COmpiling java code -- it will generate byte code 
# bcz of WORKDIR byte code will be saved in /codes 
CMD ["java","myclass"]
# default parent process 
# CMD can be used ONLy one time bcz container has single parent process 