#!/usr/bin/env bash

# credits https://github.com/Misterio77/nix-config

declare -A HOST_PORTS
HOST_PORTS["sinfonia"]=2222

hosts="$1"
shift

if [ -z "$hosts" ]; then
    echo "No hosts to deploy"
    exit 2
fi

for host in ${hosts//,/ }; do
    SSH_PORT=${HOST_PORTS[$host]:-22}

    echo "deploying $host:$SSH_PORT..."
    export NIX_SSHOPTS="-A -t -p $SSH_PORT"

    nixos-rebuild --flake .\#$host switch --target-host $host --use-remote-sudo --use-substitutes $@
done
