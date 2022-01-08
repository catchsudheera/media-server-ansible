#!/bin/bash

if ansible-playbook site.yml -i inventories/default/hosts.ini --tags start-stacks  ; then
    echo "  -- Stacks started"
else
    echo ""
    echo "+++++++++++++++++++++++++++++++++++    ERROR    +++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Starting stacks failed..."
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo ""
    exit 1
fi
