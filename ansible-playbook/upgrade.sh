#!/bin/bash

if [ -z "$1" ]
  then
    echo "Need the 'version' argument. e.g: ./upgrade.sh 1.0.1"
    exit 1
fi

VERSION=$1

echo " - Prepare for Upgrade. (target version : $VERSION)"
if ./stop-all.sh  ; then
    echo ""
else
    exit 1
fi


echo ""
echo "--------------------------------------------------------------"
echo " - Start upgrade"
ansible-playbook site.yml -i inventories/default/hosts.ini --tags "version_$VERSION"

echo ""
echo "--------------------------------------------------------------"
echo " - Start Docker containers"
./start-all.sh

