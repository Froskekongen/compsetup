#!/bin/bash

username=$1
repodir=$2
datadir=$3

dockerdatadir="/repos/data"
dockerrepodir="/repos"

docker build -t erlenda/dlcompute:latest .

wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

LINE="alias pythondocker='nvidia-docker run \
  -it -p 8888:8888 \
  -v ${datadir}:${dockerdatadir} \
  -v ${repodir}:${dockerrepodir} \
  -e DATADIR=${dockerdatadir} \
  -e REPODIR=${dockerrepodir} \
  -w=${dockerrepodir} \
  --rm=true \
  erlenda/dlcompute:latest ipython'"
ba=/home/${username}/.bash_aliases
if [ -e $ba ]; then
  grep -q "$LINE" "$ba" || echo "$LINE" >> "$ba"
else
  echo "$LINE" >> "$ba"
fi

LINE2="alias pythondockerjupyter='nvidia-docker run \
  -it -p 8888:8888 \
  -v ${datadir}:${dockerdatadir} \
  -v ${repodir}:${dockerrepodir} \
  -e DATADIR=${dockerdatadir} \
  -e REPODIR=${dockerrepodir} \
  -w=${dockerrepodir} \
  --rm=true \
  erlenda/dlcompute:latest'"
if [ -e $ba ]; then
  grep -q "$LINE2" "$ba" || echo "$LINE2" >> "$ba"
else
  echo "$LINE2" >> "$ba"
fi
