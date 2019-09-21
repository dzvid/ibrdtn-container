FROM debian:stretch-20190910-slim

# Packages default from fog-over-dtn repository (I kept them coz they seem useful to me, but not installed)
# git vim-nox net-tools tmux g++ libpth-dev make dh-autoreconf ca-certificates libicu52 libpsl0 libssl1.0.0 openssl pkg-config \ 

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
  # Copy missing build files
  && cp ibrcommon/ibrcommon/.libs/libibrcommon.so.1 /usr/lib \
  && cp ibrdtn/ibrdtn/.libs/libibrdtn.so.1 /usr/lib \
  && make install

COPY ibrdtn-default.conf ./ibrdtn/

COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

EXPOSE 4550
EXPOSE 4551
EXPOSE 4556

CMD [ "dtnd", "-c", "/ibrdtn/ibrdtn.conf"]

ENTRYPOINT ["./entrypoint.sh"]