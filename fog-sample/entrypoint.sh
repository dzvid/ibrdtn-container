#!/bin/sh

if [ ! -f /ibrdtn.conf ] ; then
    mv /ibrdtn-default.conf /ibrdtn.conf
fi

exec "$@"