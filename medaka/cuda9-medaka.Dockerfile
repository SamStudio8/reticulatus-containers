# grab an off the shelf container with cuda9
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

RUN apt-get update && apt-get install -y curl wget git python3

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python3 get-pip.py

RUN mkdir git
WORKDIR git

RUN git clone http://github.com/samstudio8/medaka.git
WORKDIR medaka
RUN git checkout tf112

# get medaka base and py requirements
RUN apt-get update && apt-get install -y bzip2 gcc zlib1g-dev libbz2-dev liblzma-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev make wget python3-all-dev python-virtualenv
#RUN pip3 install -r requirements.txt

# run medaka make (i dont really like that this yields a virtualenv tbh)
# of course if anything goes wrong that means running this entire f'ing layer again
RUN make install

ENV PATH=/git/medaka/venv/bin:$PATH
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
ENV LD_LIBRARY_PATH=/usr/local/cuda-9.0/targets/x86_64-linux/lib/stubs:$LD_LIBRARY_PATH
ENTRYPOINT medaka_consensus

