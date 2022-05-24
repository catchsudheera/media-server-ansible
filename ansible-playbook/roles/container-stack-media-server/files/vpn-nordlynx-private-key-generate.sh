#!/bin/bash

docker run --rm --cap-add=NET_ADMIN -e USER="$1" -e PASS="$2" bubuntux/nordvpn:get_private_key 2>/dev/null | grep "Private Key: " | sed 's/Private Key: //'
