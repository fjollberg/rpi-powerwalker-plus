#!/bin/bash

set -e

if ! -e /opt/pmasterp/data/pmasterpd; then
    echo "First run, installing pmasterpd into /opt/pmasterp/data..."
    cd $(dirname "$0")
    unzip pmp105_linux64.zip
    bash pmasterp105-linux-x86_x64.sh -q -dir /opt/pmasterp/data -varfile response.varfile
    rm -f pmasterp105-linux-x86_x64.sh
    echo "Installation done."
fi

echo "Launching pmasterpd..."
service pmasterpd start & trap : TERM INT; sleep infinity & wait
