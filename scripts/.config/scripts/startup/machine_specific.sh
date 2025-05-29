#!/bin/bash

THINKPAD='de06baa0779d4e27866c8ef506f6dd59'

if grep -q "$THINKPAD" /etc/machine-id; then
    xinput disable "TPPS/2 IBM TrackPoint"
fi
