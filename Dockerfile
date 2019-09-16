FROM debian:stretch

# Packages default from fog-over-dtn repository (I kept them coz they seem useful to me, but not installed)
# git vim-nox net-tools tmux g++ libpth-dev make dh-autoreconf ca-certificates libicu52 libpsl0 libssl1.0.0 openssl pkg-config \ 

#Install dependency packages (Optional packages are not installed)
RUN apt-get update && apt-get install -y \
  build-essential git net-tools vim tmux g++ libpth-dev make dh-autoreconf ca-certificates openssl pkg-config\
  libssl-dev libz-dev libsqlite3-dev \
  libcurl4-gnutls-dev libdaemon-dev automake autoconf pkg-config libtool libcppunit-dev \
  libnl-3-dev libnl-cli-3-dev libnl-genl-3-dev libnl-nf-3-dev libnl-route-3-dev libarchive-dev \
  libarchive-dev libvmime-dev libxml2-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# E: Unable to locate package libicu52
# E: Unable to locate package libpsl0
# E: Package 'libssl1.0.0' has no installation candidate

#Build repository
RUN cd \
  && git clone https://github.com/ibrdtn/ibrdtn.git ibrdtn-repo \
  && cd ibrdtn-repo/ibrdtn/ \
  && bash autogen.sh \
  && ./configure --enable-debug \
  && make \
  && cd .. \
  # Copy missing build files
  && cp ibrdtn/ibrcommon/ibrcommon/.libs/libibrcommon.so.1 /usr/lib \
  && cp ibrdtn/ibrdtn/ibrdtn/.libs/libibrdtn.so.1 /usr/lib \
  # Continue build and install
  && cd ibrdtn/ \
  && make install

COPY ibrdtn-default.conf ./ibrdtn/

COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

EXPOSE 4550

CMD [ "dtnd", "-c", "/ibrdtn/ibrdtn.conf"]

ENTRYPOINT ["./entrypoint.sh"]