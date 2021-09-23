FROM multiarch/ubuntu-debootstrap:armhf-bionic-slim
LABEL maintainer="QuinV"
RUN mkdir /root/.pip && sed -i s@/ports.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list && apt-get clean
COPY /pip.conf /root/.pip/pip.conf
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata && ln -fs /usr/share/zoneinfo/Asia/Chongqing /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y --no-install-recommends build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev curl libbz2-dev make automake gcc g++ python3-dev cmake locales firefox git cron  && \
    locale-gen zh_CN && \
    locale-gen zh_CN.utf8 && \
    cd /usr/local/src && \
    wget --no-check-certificate https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
    tar zxvf Python-3.7.4.tgz && \
    cd Python-3.7.4 && \
    mkdir /usr/local/python && \
    ./configure --with-ssl --prefix=/usr/local/python  && \
    make -j && \
    make install && cd .. && rm -rf Python* && \
    #rm -rf /usr/bin/python* &&  ln -s /usr/local/python/bin/python3 /usr/bin/python && \
    rm -rf /usr/bin/python3 && ln -s /usr/local/python/bin/python3 /usr/bin/python3 && \
    ln -s /usr/local/python/bin/pip3 /usr/bin/pip && \
    ln -s /usr/local/python/bin/pip3 /usr/bin/pip3

    #wget https://bootstrap.pypa.io/get-pip.py && python3 --no-check-certificate get-pip.py && \
ENV PATH /usr/local/python/bin:$PATH
RUN cp /usr/lib/python3/dist-packages/lsb_release.py /usr/local/python/lib/python3.7/
RUN git config --global http.sslVerify false && \
    git config --global url."https://hub.fastgit.org/".insteadOf "https://github.com/" && \
#    git clone https://github.com/protocolbuffers/protobuf.git && \
#    cd protobuf  && \
#    git checkout v3.11.3 && \
#    git submodule update --init --recursive && \
#    mkdir build_source && cd build_source && \
#    cmake ../cmake -Dprotobuf_BUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_SYSCONFDIR=/etc -DCMAKE_POSITION_INDEPENDENT_CODE=ON -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release && \
#    make -j$(nproc) && \
#    make install
#RUN touch /jksb.log && \
    echo "30 7 * * *  python3 /jksb_sysu/jksb_sysu.py" > /etc/cron.d/jksb && crontab /etc/cron.d/jksb && \
    python3 -m pip install --upgrade --no-cache-dir pip && \
    python3 -m pip install --upgrade --no-cache-dir setuptools && \
    pip install --no-cache-dir pytest-runner wheel && \
    wget --no-check-certificate https://hub.fastgit.org/nknytk/built-onnxruntime-for-raspberrypi-linux/raw/master/wheels/buster/onnxruntime-1.8.1-cp37-cp37m-linux_armv7l.whl && \
    pip install ./onnxruntime-1.8.1-cp37-cp37m-linux_armv7l.whl && rm *.whl
    #pip install --no-cache-dir  onnx
#RUN git clone https://github.com/nknytk/built-onnxruntime-for-raspberrypi-linux && \
#    cd built-onnxruntime-for-raspberrypi-linux && ./build.sh && \
#    cd .. rm -rf built* 

    #python3 -m pip install --no-cache-dir wheel numpy protobuf==3.16.0 && \
    #python3 -m pip install --no-cache-dir onnx && \
RUN git clone https://github.com/QuinV33/jksb_sysu && \
    cd jksb_sysu && chmod +x geckodriver && \
    python3 -m pip install --no-cache-dir -r requirements.txt && \
    apt clean && apt-get autoremove && rm -rf ~/.cache 
WORKDIR /
ENTRYPOINT cron &&  /bin/bash   