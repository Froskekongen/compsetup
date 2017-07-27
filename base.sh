#!/bin/bash
apt-get install -y --no-install-recommends \
  gcc \
  curl

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'



gccver=$(gcc -dumpversion)
gccmainver=$(echo $gccver | head -c 1)

apt-get update && apt-get install -y --no-install-recommends \
  libpython3-dev \
  python3-dev \
  wget \
  libstdc++-${gccmainver}-dev \
  dvipng \
  ghostscript \
  graphviz \
  libfreetype6-dev \
  zlib1g-dev \
  build-essential \
  unzip \
  linux-headers-$(uname -r) \
  linux-image-extra-virtual \
  linux-image-extra-$(uname -r) \
  docker-ce \
  oracle-java8-installer \
  git \
  zip \
  pkg-config \
  google-chrome-stable && \
  rm -rf /var/cache/oracle-jdk8-installer

groupadd docker
systemctl enable docker
# usermod -aG docker $USER


LINE="export JAVA_HOME=/usr/lib/jvm/java-8-oracle"
ba=/etc/profile.d/java_env.sh
if [ -e $ba ]; then
  grep -q "$LINE" "$ba" || echo "$LINE" >> "$ba"
else
  echo "$LINE" >> "$ba"
fi
