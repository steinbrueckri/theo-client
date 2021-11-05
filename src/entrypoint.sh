#!/bin/bash

set -e

## Configure theo-agent #######################################################

if [[ -z "${THEO_URL}" ]]; then
    echo "ERROR: Please set environment variable 'THEO_URL'"
    exit 255
fi

if [[ -z "${THEO_CLIENT_TOKEN}" ]]; then
    echo "ERROR: Please set environment variable 'THEO_TOKEN'"
    exit 255
fi

/usr/sbin/theo-agent -install -url "${THEO_URL}" -token "${THEO_CLIENT_TOKEN}" -user root -debug -no-interactive -sshd-config /etc/ssh/sshd_config

## Configure theo-cli #########################################################

if [[ -z "${THEO_ADMIN_TOKEN}" ]]; then
    echo "WARN: Environment variable 'THEO_ADMIN_TOKEN' is not set to you need to configure it by yourself!"
fi

echo "export THEO_URL=${THEO_URL}" >> /home/theo/.bashrc
echo "export THEO_TOKEN=${THEO_ADMIN_TOKEN}" >> /home/theo/.bashrc

## Start Processes ############################################################

/usr/bin/supervisord -n -c /etc/supervisord.conf
