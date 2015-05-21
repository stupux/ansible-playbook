#!/bin/bash

# Wait for the Puma socket to exist, then sleep 10 more seconds, and
# bail
while [[ ! -e /opt/rletters/root/tmp/sockets/puma.sock ]]
do
  sleep 1
done

sleep 10
