#!/bin/bash
username="$1"

wget "https://bootstrap.pypa.io/get-pip.py" && python3 get-pip.py
pippythonver=$(pip --version | grep  -o -E '(python [0-9]\.)')
rm get-pip.py

if [ "$pippythonver" == 'python 3.']; then
  echo "pip python major version: $pippythonver"
  mv /usr/local/bin/pip /usr/local/bin/pip3
fi
pip3 install -U virtualenv

venvpath=/home/${username}/compute
virtualenv -p python3 ${venvpath}
chown -R ${username}:${username} ${venvpath}

#alias actvenv="source ${venvpath}/bin/activate"
cd ${venvpath}
source ${venvpath}/bin/activate

pip install -U pip \
  numpy \
  scipy \
  scikit-learn \
  scikit-image \
  pandas \
  networkx \
  ipython \
  pillow \
  matplotlib \
  tensorflow_gpu \
  google-cloud
pip install -U git+https://github.com/fchollet/keras.git

chown -R ${username}:${username} ${venvpath}

LINE="alias pythoncomp='source ${venvpath}/bin/activate'"
ba=/home/${username}/.bash_aliases
if [ -e $ba ]; then
  grep -q "$LINE" "$ba" || echo "$LINE" >> "$ba"
else
  echo "$LINE" >> "$ba"
fi
