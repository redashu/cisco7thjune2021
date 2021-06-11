FROM oraclelinux:8.3
MAINTAINER ashutoshh
RUN dnf install java-1.8.0-openjdk.x86_64 -y
RUN mkdir  /codes
ADD hello.java /codes/
WORKDIR /codes
RUN javac hello.java 
CMD ["java","myclass"]