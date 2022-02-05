#!/bin/bash

if ansible-playbook site.yml -e nodes=localhost --connection=local --tags stop-stacks  ; then
    echo "  -- Stacks stopped"
else
    echo ""
    echo "+++++++++++++++++++++++++++++++++++    ERROR    +++++++++++++++++++++++++++++++++++++++++++++++"
    echo "There are running docker containers which did not stop. Check above ansible errors or try running this script again..."
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo ""
    exit 1
fi