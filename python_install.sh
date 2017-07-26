wget "https://bootstrap.pypa.io/get-pip.py" && python3 get-pip.py
pippythonver=$(pip --version | grep  -o -E '(python [0-9]\.)')

if [ "$pippythonver" == 'python 3.']; then
  echo "pip python major version: $pippythonver"
  mv /usr/local/bin/pip /usr/local/bin/pip3
fi

pip3 install -U pip \
  numpy \
  scipy \
  scikit-learn \
  scikit-image \
  pandas \
  networkx \
  ipython \
  pillow \
  matplotlib \
  tensorflow_gpu
pip3 install -U git+https://github.com/fchollet/keras.git
