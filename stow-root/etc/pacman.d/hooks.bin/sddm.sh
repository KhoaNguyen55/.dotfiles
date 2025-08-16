#!/usr/bin/env bash
mkdir /usr/share/wallpapers/
touch /usr/share/wallpapers/wal
chmod 0666 /usr/share/wallpapers/wal
systemctl enable sddm
