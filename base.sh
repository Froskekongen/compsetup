apt-get install -y --no-install-recommends \
  gcc \
  curl

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

gccver=$(gcc -dumpversion)
gccmainver=$(echo $gccver | head -c 1)

apt-get update && apt-get install -y --no-install-recommends \
  libpython3-dev \
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
  docker-ce

groupadd docker
systemctl enable docker
# usermod -aG docker $USER
