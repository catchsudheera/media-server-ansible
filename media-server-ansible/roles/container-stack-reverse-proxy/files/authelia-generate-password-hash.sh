#!/bin/bash

docker run authelia/authelia:latest authelia hash-password "$1" | sed 's/Password hash: //'
