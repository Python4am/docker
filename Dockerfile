FROM ubuntu:bionic
LABEL maintainer="QuinV"
ENV LANG     zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8
ENV LC_ALL   zh_CN.UTF-8
RUN mkdir /root/.pip && sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list  && sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && apt-get clean
COPY /pip.conf /root/.pip/pip.conf
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata && ln -fs /usr/share/zoneinfo/Asia/Chongqing /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y --no-install-recommends python3.8 python3-pip locales firefox git cron && echo 'alias python3="python3.8"' >> ~/.bashrc && \
    locale-gen zh_CN && \
    locale-gen zh_CN.utf8 && \
    rm -rf /usr/bin/python3 && ln -s /usr/bin/python3.8 /usr/bin/python3 && \ 
    git config --global url."https://hub.fastgit.org/".insteadOf "https://github.com/" && \
    git clone https://github.com/QuinV33/jksb_sysu && \
    touch /jksb.log && \
    echo "30 7 * * *  python3 /jksb_sysu/jksb_sysu.py" > /etc/cron.d/jksb && crontab /etc/cron.d/jksb && \
    python3 -m pip install -U --no-cache-dir  pip setuptools && \
    cd jksb_sysu && chmod +x geckodriver && \
    python3 -m pip install --no-cache-dir -r requirements.txt && \
    apt clean && apt-get autoremove && rm -rf ~/.cache
WORKDIR /
ENTRYPOINT cron &&  /bin/bash   