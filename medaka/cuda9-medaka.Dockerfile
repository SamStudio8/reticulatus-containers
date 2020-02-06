# grab an off the shelf container with cuda9
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
RUN apt-get update && apt-get install -y curl wget git python3

# install git lfs
# https://askubuntu.com/questions/799341/how-to-install-git-lfs-on-ubuntu-16-04
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get update && apt-get install git-lfs

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python3 get-pip.py

RUN mkdir git
RUN git --version
WORKDIR git

RUN git clone http://github.com/nanoporetech/medaka.git
WORKDIR medaka

# checkout v11.5
RUN git checkout c9df97747038352b4806f88e5e53b514ed8f89f2

# Hack to make tensorflow 1.12 work so we can use this on GRID/PROM with CUDA9
RUN wget https://raw.githubusercontent.com/SamStudio8/reticulatus-containers/master/medaka/tf112.patch
RUN patch medaka/prediction.py -i tf112.patch
RUN sed -i 's,tensorflow==1.14.0,tensorflow-gpu==1.12.0,' requirements.txt

# get medaka base and py requirements
RUN apt-get update && apt-get install -y bzip2 g++ zlib1g-dev libbz2-dev liblzma-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev curl make cmake wget python3-all-dev python-virtualenv
#RUN pip3 install -r requirements.txt

# run medaka make (i dont really like that this yields a virtualenv tbh)
# of course if anything goes wrong that means running this entire f'ing layer again
# Use mini_align that permits overriding of $SORT and threaded indexing
RUN make install

ENV PATH=/git/medaka/venv/bin:$PATH
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
ENV LD_LIBRARY_PATH=/usr/local/cuda-9.0/targets/x86_64-linux/lib/stubs:$LD_LIBRARY_PATH
ENTRYPOINT medaka_consensus

