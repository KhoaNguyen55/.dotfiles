#!/usr/bin/env bash
echo "EARLYOOM_ARGS=\"-m 10 -r 3600 --avoid '(^|/)(init|systemd|Xorg|sshd|qemu-system-x86_64)$'\"" | tee /etc/default/earlyoom
systemctl enable earlyoom --now
