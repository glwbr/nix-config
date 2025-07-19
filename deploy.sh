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

    echo "Deploying $host on port $SSH_PORT..."
    export NIX_SSHOPTS="-A -p $SSH_PORT"

    # TODO: fix this, probably mDns issue
    nixos-rebuild switch \
        --flake ".#$host" \
        --target-host 192.168.0.2 \
        --sudo \
        --ask-sudo-password \
        --use-substitutes \
        "$@"
done
