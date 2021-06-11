FROM ubuntu
RUN apt update -y
RUN  apt install python3-pip python3 -y
COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt 
EXPOSE 5000
ENTRYPOINT [ "python3" ] 
CMD [ "demo.py" ] 

