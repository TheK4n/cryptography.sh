#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
    echo "luks: Please run as root" >&2
    exit 1
fi



case "$1" in
  "close")
    sudo umount /mnt/Files &>/dev/null && sudo cryptsetup luksClose Files || echo "luks: Already unmounted" >&2
    exit 0
    ;;
  "open")
    sudo cryptsetup luksOpen /dev/sdb5 Files && sudo mount /dev/mapper/Files /mnt/Files && echo "luks: Successfully decrypted"
    exit 0
    ;;
  \?)
    echo "luks: Invalid option: $1" >&2 && exit 2

    ;;
esac


echo "luks: No option, open, close" >&2 && exit 3

