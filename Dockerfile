FROM debian:stretch-slim

RUN apt-get update && apt-get install -y \
  build-essential git net-tools g++ libpth-dev make dh-autoreconf ca-certificates openssl pkg-config\
  libssl-dev libz-dev libsqlite3-dev \
  libcurl4-gnutls-dev libdaemon-dev automake autoconf pkg-config libtool libcppunit-dev \
  libnl-3-dev libnl-cli-3-dev libnl-genl-3-dev libnl-nf-3-dev libnl-route-3-dev libarchive-dev \
  libarchive-dev libvmime-dev libxml2-dev --no-install-recommends\
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Build IBRDTN
RUN git clone https://github.com/ibrdtn/ibrdtn.git build/ibrdtn-repo \
  && cd /build/ibrdtn-repo/ibrdtn \
  && bash autogen.sh \
  && ./configure --enable-debug \
  && make \
  # Copy missing build files
  && cp ibrcommon/ibrcommon/.libs/libibrcommon.so.1 /usr/lib \
  && cp ibrdtn/ibrdtn/.libs/libibrdtn.so.1 /usr/lib \
  && make install \
  && cd \
  && rm -rf /build \
  && mkdir -p /ibrdtn/config /ibrdtn/bundles /ibrdtn/log


VOLUME [ "/ibrdtn/config", "/ibrdtn/bundles", "/ibrdtn/log" ]

COPY ibrdtn.conf ./ibrdtn/config

COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

CMD [ "dtnd", "-c", "/ibrdtn/config/ibrdtn.conf"]

ENTRYPOINT ["./entrypoint.sh"]