#!/bin/bash

docker run --rm authelia/authelia:latest authelia hash-password "$1" 2>/dev/null | grep "Password hash: " | sed 's/Password hash: //'
