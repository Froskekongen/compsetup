#!/bin/bash
## Assumes access to runfile installation of cuda toolkit and cudnn tarfile


runfiledir=$1
runfilename=$2
user=$3
cd $runfiledir
chmod +x ${runfilename}

./${runfilename} --tar mxvf

cp InstallUtils.pm /usr/lib/x86_64-linux-gnu/perl-base

./${runfilename} --override --silent --toolkit

ln -s /usr/local/cuda-8.0 /usr/local/cuda


LINE1="#if __GNUC__ > 5"
LINE2="#error -- unsupported GNU version! gcc versions later than 5 are not supported!"
LINE3="#endif \/\* __GNUC__ > 5 \*\/"


file1="/usr/local/cuda-8.0/include/host_config.h"
#file1="host_config.h"


sed -i "/${LINE1}/ { c \
//${LINE1}
}" ${file1}

sed -i "/${LINE2}/ { c \
//${LINE2}
}" ${file1}

sed -i "/${LINE3}/ { c \
//${LINE3}
}" ${file1}

tar xvfz cudnn-8.0-linux-x64-v6.0.tgz
cp -r cuda/* /usr/local/cuda-8.0

echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf && \
    ldconfig

## Not sure which option is best
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
apt-get update && apt-get install -y --no-install-recommends bazel

#wget 'https://github.com/bazelbuild/bazel/releases/download/0.5.2/bazel-0.5.2-installer-linux-x86_64.sh'
#chmod +x bazel-0.5.2-installer-linux-x86_64.sh
#./bazel-0.5.2-installer-linux-x86_64.sh

EXTRA_NVCCFLAGS="-Xcompiler -std=c++98 -D__CORRECT_ISO_CPP11_MATH_H_PROTO"

cd /home/${user}
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
