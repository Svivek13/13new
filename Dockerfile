FROM  phusion/baseimage:0.9.17

RUN apt-get -y update

COPY ./src/main/java/Academy/App.java ./src/main/java/Academy/App.java

WORKDIR /src/main/java/Academy/App.java

CMD ["phusion/baseimage:0.9.17",App.java]
