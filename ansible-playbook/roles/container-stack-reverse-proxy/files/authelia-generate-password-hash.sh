#!/bin/bash

# pinning the version to 4.37 , so that the output of the hash-password is consistent
docker run --rm authelia/authelia:4.37 authelia hash-password "$1" 2>/dev/null | grep "Digest: " | sed 's/Digest: //'
