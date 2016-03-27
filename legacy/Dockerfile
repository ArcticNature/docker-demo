FROM fedora:21
MAINTAINER Stefano Pogliani


# Update system and DNF cache and install needed dependencies.
RUN yum update -y

RUN yum install -y  \
  file  \
  cmake  \
  gcc-c++  \
  git  \
  hostname  \
  http-parser-devel  \
  libcurl-devel  \
  libssh2-devel  \
  lua-devel  \
  make  \
  openssl-devel  \
  protobuf-compiler  \
  protobuf-devel  \
  tar  \
  wget


# Move activity to a dedicated directory.
RUN mkdir -p /opt/snow-fox-source
WORKDIR /opt/snow-fox-source


# Install Node.js and NPM.
RUN curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -  \
  && yum install -y nodejs  \
  && npm install -g grunt-cli


# Install latest version of GFlags.
RUN wget https://github.com/gflags/gflags/archive/v2.1.2.tar.gz  \
  -O gflags.tar.gz  \
  && mkdir -p gflags/build  \
  && tar --extract --file gflags.tar.gz --strip 1 --directory gflags  \
  && cd gflags/build  \
  && cmake -DBUILD_SHARED_LIBS=yes ..  \
  && make install  \
  && cp /usr/local/lib/libgflags.so.2 /usr/lib64/


# Pull, compile, and install the code.
RUN git clone https://github.com/stefano-pogliani/snow-fox.git  \
  && cd snow-fox  \
  && npm install  \
  && grunt distribute  \
  && cp --recursive --preserve=all out/packages/snow-fox /opt/  \
  && mkdir -p /var/snow-fox/instances  \
  && cd /opt/snow-fox/clients/json  \
  && npm install

# Deploy default configuration.
COPY start-default.sh /opt/snow-fox/bin/start-default.sh

RUN mkdir -p /opt/snow-fox/etc  \
  && git clone https://github.com/stefano-pogliani/snow-fox-example-config.git /opt/snow-fox/etc/example-config  \
  && chmod +x /opt/snow-fox/bin/start-default.sh  \
  && ln -s /opt/snow-fox/clients/json /opt/snow-fox/clients/json/module


# Set entry point to bash because this is a testing image.
ENTRYPOINT ["/bin/bash"]
