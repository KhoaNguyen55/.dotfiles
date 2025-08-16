#!/usr/bin/env bash
vm=`sed -n "s/.*start_vm=//p" /proc/cmdline | cut -d " " -f1`
[ "$(/bin/virsh domstate "$vm")" == "running" ] || /bin/virsh start "$vm"
