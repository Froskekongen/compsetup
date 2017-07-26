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


#file1="/usr/local/cuda-8.0/include/host_config.h"
file1="host_config.h"


sed -i "/${LINE1}/ { c \
//${LINE1}
}" ${file1}

sed -i "/${LINE2}/ { c \
//${LINE2}
}" ${file1}

sed -i "/${LINE3}/ { c \
//${LINE3}
}" ${file1}


EXTRA_NVCCFLAGS="-Xcompiler -std=c++98"
