#!/bin/sh

if [ ! -f /ibrdtn/ibrdtn-default.conf ] ; then
    mv /ibrdtn-default.conf /ibrdtn/ibrdtn-default.conf
fi

exec "$@"