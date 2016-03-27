FROM fedora:23
MAINTAINER Stefano Pogliani


# Update system and DNF cache and install needed dependencies.
RUN dnf update -y

RUN dnf install -y  \
  file  \
  cmake  \
  gcc-c++  \
  git  \
  hostname  \
  make  \
  openssl-devel  \
  protobuf-compiler  \
  protobuf-devel  \
  tar  \
  wget


# Install Node.js and NPM.
RUN curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -  \
  && dnf install -y nodejs  \
  && npm install -g grunt-cli


# Move activity to a dedicated directory.
RUN mkdir -p /opt/snow-fox-source
WORKDIR /opt/snow-fox-source


# Pull, compile, and install the code.
RUN git clone https://github.com/ArcticNature/snow-fox.git --recursive  \
  && cd snow-fox  \
  && npm install  \
  && grunt distribute  \
  && mkdir -p /opt/  \
  && cp --recursive --preserve=all out/packages/snow-fox /opt/


# Set entry point to bash because this is a testing image.
ENTRYPOINT ["/bin/bash"]
