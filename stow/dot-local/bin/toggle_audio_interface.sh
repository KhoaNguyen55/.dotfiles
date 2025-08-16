#!/bin/env bash

port=`pactl list | grep -oPi '(active port: analog-output-)\K.*' | tail -n 1`

if [[ $port = "headphones" ]]; then
    pactl set-sink-port 0 analog-output-lineout
else
    pactl set-sink-port 0 analog-output-headphones
fi
