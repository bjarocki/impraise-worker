#!/usr/bin/env bash

if [ $# != 1 ]; then
  echo "Usage: $0 [environment]" >&2
  exit 1
fi

ENVIRONMENT="$1"
RHOST="ssh.$ENVIRONMENT.nowthis.network"

set -x
set -e

IPADDR=$(ssh $RHOST ip addr ls dev eth1.0000 | awk '/inet/ { print $2 }' | cut -d \/ -f 1)

ssh $RHOST \
  -L localhost:4646:$IPADDR:4646 \
  -L localhost:8500:$IPADDR:8500 \
  -N -x -v
