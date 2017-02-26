FROM debian:jessie

MAINTAINER d.makovkin@ceteralabs.com

ENV OPENFIRE_VERSION=4_1_2
ENV JAVA_HOME /opt/java

RUN apt-get update && apt-get upgrade -y && apt-get install -y locales wget
RUN echo "Europe/Moscow" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen
RUN echo 'LANG="ru_RU.UTF-8"' > /etc/default/locale
RUN dpkg-reconfigure --frontend=noninteractive locales
RUN update-locale LANG=ru_RU.UTF-8

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz -O /tmp/jdk-8u121-linux-x64.tar.gz
RUN wget "http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}.tar.gz" -O /tmp/openfire_${OPENFIRE_VERSION}.tar.gz

RUN cd /opt && tar zxvf /tmp/openfire_${OPENFIRE_VERSION}.tar.gz && tar zxvf /tmp/jdk-8u121-linux-x64.tar.gz
RUN ln -s /opt/jdk1.8.0_121 /opt/java
RUN rm -rf /tmp/*.tar.gz
RUN apt-get -y clean

ADD startup.sh /startup.sh
RUN chmod 755 /startup.sh

CMD ["/startup.sh"]
