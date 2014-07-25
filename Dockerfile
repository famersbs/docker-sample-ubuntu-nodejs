
FROM ubuntu

# Update System
#RUN apt-get -y install apt-file
#RUN add-apt-repository ppa:chris-lea/node.js

RUN apt-get -y update
RUN apt-get -y upgrade

# Install help app
RUN apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++
RUN apt-get -y install wget
RUN apt-get -y install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
RUN apt-get -y install checkinstall

# Download & unpack python
WORKDIR /tmp
RUN wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tgz
RUN tar -xvf Python-2.7.5.tgz
WORKDIR /tmp/Python-2.7.5
RUN ./configure
RUN make
RUN make install

# Download & Unpack Node.js - v. 0.6.8
RUN mkdir /tmp/node-install
WORKDIR /tmp/node-install
RUN wget http://nodejs.org/dist/v0.10.29/node-v0.10.29.tar.gz
RUN tar -zxf node-v0.10.29.tar.gz

RUN cd node-v0.10.29;./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "0.10.29" --default

WORKDIR /

# Bundle project source
ADD ./src /opt/src

RUN ls /opt/src

## Install project dependencies
RUN cd /opt/src; npm install

EXPOSE  8888

#RUN ufw disable

# Run the node server
CMD ["node", "/opt/src/index.js"]