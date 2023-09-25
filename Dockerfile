FROM ubuntu:18.04

RUN apt-get update && apt-get install gnuradio -y
RUN apt-get install git cmake swig pkg-config -y

RUN git clone https://github.com/bastibl/gr-ieee802-15-4.git \
    && cd gr-ieee802-15-4 && git checkout maint-3.7 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && ldconfig

RUN git clone https://github.com/hhornbacher/gr-ble.git \
    && cd gr-ble && git checkout master \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && ldconfig

RUN grcc gr-ieee802-15-4/examples/ieee802_15_4_OQPSK_PHY.grc

RUN git clone https://github.com/bastibl/gr-foo.git \
&& cd gr-foo \
&& git checkout maint-3.7 \
&& mkdir build \
&& cd build \
&& cmake .. \
&& make \
&& make install \
&& ldconfig

RUN git clone https://github.com/BastilleResearch/scapy-radio.git \
&& cd scapy-radio \
&& sed -i "s/sudo//" install.sh\
&& ./install.sh

RUN /usr/bin/uhd_images_downloader
RUN apt install -y wireless-tools net-tools iproute2 tcpdump

RUN git clone https://github.com/gefa/gr-lora.git \
&& cd gr-lora \
&& git checkout main \
&& mkdir build \
&& cd build \
&& cmake .. \
&& make \
&& make install \
&& ldconfig

RUN apt-get update && apt-get install -y python3-dev python3-pip build-essential libzmq3-dev
RUN pip3 install pyzmq

RUN apt-get update --fix-missing && apt -y install cmake git g++ libboost-all-dev python-dev python-mako \
python-numpy python-wxgtk3.0 python-sphinx python-cheetah swig \
libzmq3-dev libfftw3-dev libgsl-dev libcppunit-dev doxygen libcomedi-dev \
libqt4-opengl-dev python-qt4 libqwt-dev libsdl1.2-dev libusb-1.0-0-dev \
python-gtk2 python-lxml pkg-config python-sip-dev python-setuptools

RUN git clone https://github.com/EttusResearch/uhd && cd uhd && git checkout UHD-3.15.LTS && cd host && mkdir build && cd build && cmake -DPYTHON_EXECUTABLE=/usr/bin/python2 ../ && make -j3 && make test && make install && ldconfig

RUN git clone https://github.com/gefa/gnuradio3.7.git gnuradio3.7 && cd gnuradio3.7 && git submodule update --init --recursive && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DPYTHON_EXECUTABLE=/usr/bin/python2 \
-DENABLE_GR_DIGITAL=ON -DENABLE_GNURADIO_RUNTIME=ON -DENABLE_GR_FFT=ON \
-DENABLE_GR_FILTER=ON -DENABLE_GR_BLOCKS=ON -DENABLE_GR_ANALOG=ON \
-DENABLE_GR_UHD=ON ../ && make -j3 && make install && ldconfig

RUN git clone https://github.com/gefa/-gr-mapper.git gr-mapper && cd gr-mapper && mkdir build && cd build && cmake .. && make && make install && ldconfig

