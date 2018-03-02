FROM ubuntu:18.04

ENV http_proxy ${http_proxy:-}
ENV https_proxy ${https_proxy:-}
ENV no_proxy ${no_proxy:-}
ENV OUT_DIR_COMMON_BASE /temp/out/dist
ENV USER root

RUN apt-get update && apt-get -y upgrade

# install all of the tools and libraries that we need.
RUN apt-get update && apt-get install -y git-core gnupg flex \
       bison gperf build-essential zip curl \
       zlib1g-dev gcc-multilib g++-multilib \
       libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev \
       libx11-dev lib32z-dev ccache libgl1-mesa-dev \
       libxml2-utils xsltproc unzip openjdk-8-jdk python

ADD https://commondatastorage.googleapis.com/git-repo-downloads/repo /usr/local/bin/
RUN chmod 755 /usr/local/bin/*

# We need this because of this https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/
# Here is solution https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
RUN curl --create-dirs -sSLo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64
RUN chmod +x /usr/local/bin/dumb-init

# setting up CCACHE
RUN mkdir /ccache
RUN echo "export USE_CCACHE=1" >> /etc/profile.d/android
ENV USE_CCACHE 1
ENV CCACHE_DIR /ccache

WORKDIR /aosp
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["bash"]
