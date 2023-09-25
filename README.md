# gnuradio-3.7

Docker build of gnuradio-3.7, from source, on Ubuntu 18.04.

Build locally using the build instructions, if you want.

Or, this image is also pushed to [Theseus Cores Docker Hub](https://hub.docker.com/r/theseuscores/gnuradio),
so you can jump straight to the "running" section without doing a local build.


## Build instructions

`docker build -t grc3.7 .`

Pick your name instead of grc3.x. There's also a number of override-able parameters in the Dockerfile that
can be used to specify Gnuradio and UHD configuration.

## Running

Run the docker image, with volume mounts for running gnuradio-companion
and a data directory:

```
./run-over-network grc3.7
```

For an additional shell run:

```
docker exec -it grc3.7 bash
```

## GRAND_CRC
GRAND_CRC software can be divided into two code bases, GNU Radio 3.7 repository and gr-mapper out-of-tree (OOT) module.
GNU Radio repository contains modified "Stream CRC32" decoder block residing in 
gnuradio/gr-digital/lib/crc32_bb_impl.cc, which serves as GRAND_CRC decoder.
OOT module gr-mapper contains the simulation (prbs_test_crc.grc) and over-the-air (prbs_test_crc_usrp.grc) flowgraphs.

GNU Radio repository: https://github.com/gefa/gnuradio3.7
gr-mapper: https://github.com/gefa/-gr-mapper/tree/master

```
sudo apt-get install docker # install docker
docker build -t grc3.7 . # build docker image
./run-over-network.sh grc3.7 # run docker containter
gnuradio@gefa-ThinkPad-X1-Yoga-2nd:~$

$ cd gr-mapper/apps
$ grcc prbs_test_crc.grc # build simulation flowgraph
$ /gr-mapper/apps/prbs_test_crc.py # run simulation
$ grcc prbs_test_crc_usrp.grc # build over-the-air flowgraph
$ /gr-mapper/apps/prbs_test_crc_usrp.py # run over-the-air experiment

# collect and analyze recoded data
$ apt-get install python3-matplotlib
$ python3 sweep_ber.py 1 # simulate 1 bit abandonment threshold trials
# plot csv files with 95% confidence intervals
$ python3 plot_csv.py snr_bler_grand_0_20230911232423.csv \
snr_bler_grand_1_20230911225427.csv --labels GRAND-0 GRAND-1
```
