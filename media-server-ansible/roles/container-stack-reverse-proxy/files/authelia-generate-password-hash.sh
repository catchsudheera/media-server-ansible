#!/bin/bash

docker run authelia/authelia:latest authelia hash-password "$1" 2>/dev/null | grep "Password hash: " | sed 's/Password hash: //'
