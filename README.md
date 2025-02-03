# meshtastic-bakery
Docker in-place build container for Meshtastic

build the container

`docker build -t meshtastic-bakery:6.1.16 --build-arg version=6.1.16 -f Dockerfile .`
  
checkout the meshtastic firmware version you want to build (example: v2.5.20)

`git checkout -b v2.5.20.4c97351 https://github.com/meshtastic/firmware.git`
  
change to the directory and run the container (example: build tbeam)

``cd firmware; docker run -e PIO_ARCH=esp32 -e PIO_ENV=tbeam -e HOME=`pwd` -u $UID -w `pwd` -v `pwd`:`pwd` --rm -it docker.io/library/meshtastic-bakery:6.1.16``
  
after the command finishes you'll find your firmware in the release directory.
