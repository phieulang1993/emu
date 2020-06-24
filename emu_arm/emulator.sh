#!/bin/bash

sudo apt-get install qemu-system-arm -y

if [ ! -f "vmlinuz-3.2.0-4-vexpress" ]; then
    wget https://people.debian.org/~aurel32/qemu/armhf/vmlinuz-3.2.0-4-vexpress
fi
if [ ! -f "debian_wheezy_armhf_standard.qcow2" ]; then
    wget https://people.debian.org/~aurel32/qemu/armhf/debian_wheezy_armhf_standard.qcow2
fi
if [ ! -f "initrd.img-3.2.0-4-vexpress" ]; then
    wget https://people.debian.org/~aurel32/qemu/armhf/initrd.img-3.2.0-4-vexpress
fi

sudo qemu-system-arm -M vexpress-a9 -nographic \
    -kernel vmlinuz-3.2.0-4-vexpress \
    -initrd initrd.img-3.2.0-4-vexpress \
    -drive if=sd,file=debian_wheezy_armhf_standard.qcow2 \
    -append "root=/dev/mmcblk0p2" \
    -net user,hostfwd=tcp::80-:80,hostfwd=tcp::8008-:8008,hostfwd=tcp::2222-:22,hostfwd=tcp::8181-:8181,hostfwd=tcp::9999-:9999,hostfwd=tcp::443-:443 \
    -net nic -no-reboot
