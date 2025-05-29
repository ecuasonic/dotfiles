#!/bin/bash

id_hash=$(sha256sum /etc/machine-id | awk '{print $1}')

THINKPAD_hash='10e5fa2ff74be5a896c3e2bc9637c8761e32fe94b95388738ed37f3e541c1f9d'
G14_hash='9c4df82c32b181edd16f1050254ae731e49f46e63545df81a31cfcfd49fe6efe'

if [[ "$id_hash" == "$THINKPAD_hash" ]]; then
    xinput disable "TPPS/2 IBM TrackPoint"
fi
