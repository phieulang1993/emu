#!/bin/bash

sudo apt-get install qemu-system-mips -y

if [ ! -f "vmlinux-2.6.32-5-4kc-malta" ]; then
    wget https://people.debian.org/~aurel32/qemu/mips/vmlinux-2.6.32-5-4kc-malta
fi
if [ ! -f "debian_squeeze_mips_standard.qcow2" ]; then
    wget https://people.debian.org/~aurel32/qemu/mips/debian_squeeze_mips_standard.qcow2
fi

sudo qemu-system-mips -m 1024M -M malta \
    -nographic \
    -kernel vmlinux-2.6.32-5-4kc-malta \
    -hda debian_squeeze_mips_standard.qcow2 \
    -append "root=/dev/sda1 console=tty0" \
    -device VGA \
    -net user,hostfwd=tcp::80-:80,hostfwd=tcp::443-:443,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:8080,hostfwd=tcp::9999-:9999 \
    -net nic
