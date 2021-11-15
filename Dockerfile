FROM  phusion/baseimage:0.9.17

RUN apt-get -y update

COPY /Automation-master/src/main/java/Academy/App.java /Automation-master/src/main/java/Academy/App.java

WORKDIR /Automation-master/src/main/java/Academy/App.java

CMD ["phusion/baseimage:0.9.17",App.java]
