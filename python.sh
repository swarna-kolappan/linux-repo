#!/bin/bash

#########################################
# Installing python and necessary packages
# locally. This script will install python
# into the ~/local/bin directory and install
# numpy + scipy
#########################################

# installing python 3.6.3
mkdir -p ~/local
wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz
tar xvzf Python-3.6.3.tgz
cd Python-3.6.3
./configure
make
make altinstall prefix=~/local  # specify local installation directory
ln -s ~/local/bin/python3.6 ~/local/bin/python
cd ..

# install setuptools and pip for package management
wget http://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz#md5=7df2a529a074f613b509fb44feefe74e
tar xvzf setuptools-0.6c11.tar.gz
cd setuptools-0.6c11
~/local/bin/python setup.py install  # specify the path to the python you installed above
cd ..
wget http://pypi.python.org/packages/source/p/pip/pip-1.2.1.tar.gz#md5=db8a6d8a4564d3dc7f337ebed67b1a85
tar xvzf pip-1.2.1.tar.gz
cd pip-1.2.1
~/local/bin/python setup.py install  # specify the path to the python you installed above

# Now you can install other packages using pip
~/local/bin/pip install numpy  # install numpy
~/local/bin/pip install scipy

~/local/bin/pip freeze  # to check python module version info