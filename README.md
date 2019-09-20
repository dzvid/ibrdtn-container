# IBRDTN - Dockerfile 🐳

Dockerfile to build a docker image for the Bundle protocol implementation [IBRDTN](https://github.com/ibrdtn/ibrdtn).
The image use debian:stretch-20190910-slim as base image, the code in this repository was created based on
the project [fog-over-dtn](https://github.com/tukno/fog-over-dtn/tree/master/Fog%20Node/IBR-DTN).

## Usage

1. Download the repository or clone to your machine:

   ```bash
   git clone git@github.com:tukno/ibrdtn-container.git
   ```

2. Build the image:

   ```bash
   cd ibrdtn-container
   docker build .
   ```

## License

The repository code/resources are [GPLv3 licensed](./LICENSE).
