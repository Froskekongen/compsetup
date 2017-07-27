FROM tensorflow/tensorflow:1.3.0-rc0-py3

MAINTAINER Erlend Aune <erlend.aune.1983@gmail.com>

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java


RUN apt-get update && apt-get install --no-install-recommends -y  \
  wget \
  dvipng \
  ghostscript \
  graphviz \
  git \
  oracle-java8-installer && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


RUN pip install -U --no-cache-dir pip \
  numpy \
  scipy \
  scikit-learn \
  scikit-image \
  pandas \
  networkx \
  ipython \
  pillow \
  matplotlib
RUN pip install -U --no-cache-dir git+https://github.com/fchollet/keras.git


RUN mkdir -p /repos/data
