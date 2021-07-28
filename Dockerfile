FROM debian:buster

ENV OPENH264_VERSION=2.1.1 \
FFMPEG_VERSION=4.4 

RUN apt-get update && apt-get install -y \
&& apt-get install -y build-essential nasm pkg-config automake autoconf zlib1g-dev libtool yasm libmp3lame-dev wget \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& wget https://github.com/cisco/openh264/archive/v${OPENH264_VERSION}.tar.gz \
&& tar zxf v${OPENH264_VERSION}.tar.gz\
&& cd openh264-${OPENH264_VERSION} \
&& make && make install \
&& ldconfig \
&& cd - \
&& rm -f v${OPENH264_VERSION}.tar.gz \
&& rm -rf openh264-${OPENH264_VERSION} \
&& wget http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 \
&& tar xjf ffmpeg-${FFMPEG_VERSION}.tar.bz2 \
&& cd ffmpeg-${FFMPEG_VERSION} \
&& ./configure \
    --enable-libopenh264 \
    --enable-libmp3lame \
&& make && make install \
&& cd - \
&& rm -f ffmpeg-${FFMPEG_VERSION}.tar.bz2 \
&& rm -rf ffmpeg-${FFMPEG_VERSION}
