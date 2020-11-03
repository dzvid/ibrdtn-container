# IBRDTN - Dockerfile 🐳

Dockerfile to build a docker image for the Bundle protocol implementation [IBRDTN](https://github.com/ibrdtn/ibrdtn).
The image use debian:stretch-20190910-slim as base image, the code in this repository was created based on
the project [fog-over-dtn](https://github.com/tukno/fog-over-dtn/tree/master/Fog%20Node/IBR-DTN).

## Usage

1. Download the repository or clone to your machine:

   ```bash
   git clone git@github.com:tukno/ibrdtn-container.git
   ```

2. Clone the ibrdtn repository :

   ```bash
   cd ibrdtn-container
   git clone https://github.com/ibrdtn/ibrdtn.git
   ```
3. Build the image:
   ```bash
   docker build . -t insert_tag_name
   ```
  To build for arm32v7:
   ```bash
   docker build . -t insert_tag_name -f Dockerfile-arm
   ```


## License

The repository code/resources are licensed under [Apache 2.0 license](./LICENSE).
