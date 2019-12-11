FROM debian:stretch-20190910-slim

# Packages default from fog-over-dtn repository (I kept them coz they seem useful to me, but not installed)
# git vim-nox net-tools tmux g++ libpth-dev make dh-autoreconf ca-certificates libicu52 libpsl0 libssl1.0.0 openssl pkg-config \ 


COPY ./ibrdtn/ /build/ibrdtn-repo

#Install dependency packages (Optional packages are not installed)
# Removed: vim tmux 
RUN apt-get update && apt-get install -y \
  build-essential git net-tools g++ libpth-dev make dh-autoreconf ca-certificates openssl pkg-config\
  libssl-dev libz-dev libsqlite3-dev \
  libcurl4-gnutls-dev libdaemon-dev automake autoconf pkg-config libtool libcppunit-dev \
  libnl-3-dev libnl-cli-3-dev libnl-genl-3-dev libnl-nf-3-dev libnl-route-3-dev libarchive-dev \
  libarchive-dev libvmime-dev libxml2-dev --no-install-recommends\
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN cd /build/ibrdtn-repo/ibrdtn \
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

COPY ibrdtn.conf ./ibrdtn/config

VOLUME [ "/ibrdtn/bundles", "/ibrdtn/log" ]

COPY ibrdtn.conf ./ibrdtn/

COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

CMD [ "dtnd", "-c", "/ibrdtn/config/ibrdtn.conf"]

ENTRYPOINT ["./entrypoint.sh"]