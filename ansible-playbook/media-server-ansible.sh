#!/bin/bash

# This script is the entrypoint to the installation/management and updgrade triggers.

ACTIONS=(install upgrade start-all-containers stop-all-containers)

usage() {
  echo "Usage: $0 [OPTION]..." 1>&2
  echo "Gives the ability to trigger installation/upgrade or manage already installed media server environment"
  echo ""
  echo "   -a, --action         Required. The action being performed. Should be one of : [ ${ACTIONS[*]} ]"
  echo "   -h, --help           Prints this help menu"
}

exit_non_ok() {
  usage
  exit 1
}

containsElement() {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

stop_all() {
  if ansible-playbook site.yml $PLAYBOOK_ARGS --tags stop-stacks  ; then
    echo "  -- Stacks stopped"
  else
      echo ""
      echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++    ERROR    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      echo "  There are running docker containers which did not stop. Check above ansible errors or try running this script again..."
      echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      echo ""
      exit 1
  fi
}

start_all() {
  if ansible-playbook site.yml $PLAYBOOK_ARGS --tags start-stacks ; then
      echo "  -- Stacks started"
  else
      echo ""
      echo "+++++++++++++++++++++++++++++++++++    ERROR    +++++++++++++++++++++++++++++++++++++++++++++++"
      echo "                            Starting stacks failed..."
      echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      echo ""
      exit 1
  fi
}

install() {
  echo " - Prepare for installation"
  if ! stop_all ; then
      echo " Preparation step failed. Stopping the installation..!!!"
      exit 1
  fi

  echo ""
  echo "--------------------------------------------------------------"
  echo " - Start installation"
  ansible-playbook site.yml $PLAYBOOK_ARGS
}

ACTION=
INSTALLATION_HOST=localhost
CONNECTION_TYPE=local

# arg parse block
VALID_ARGS=$(getopt -o ha: --long help,action: -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi

eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
    -h | --help)
      usage
      exit 0
      shift
      ;;

    -a | --action)
      ACTION="$2"
      if ! containsElement "$ACTION" "${ACTIONS[@]}"; then echo "Incorrect --action argument. Should be one of : [ ${ACTIONS[*]} ]"; exit 1 ; fi
      shift 2
      ;;

    --) shift;
        break
        ;;
  esac
done

if [ -z "$ACTION" ]; then
  echo " --action argument is required..!"
  echo
  usage
fi

PLAYBOOK_ARGS="-i $INSTALLATION_HOST, --connection=$CONNECTION_TYPE"

if ! sudo -n true 2>/dev/null; then
  PLAYBOOK_ARGS="$PLAYBOOK_ARGS -K"
fi

echo "Running ansible-playbook with args : $PLAYBOOK_ARGS"
echo

if [ "$ACTION" = "install" ]; then
    install
elif [ "$ACTION" = "upgrade" ]; then
    echo "Upgrade is not supported yet"
elif [ "$ACTION" = "start-all-containers" ]; then
    start_all
elif [ "$ACTION" = "stop-all-containers" ]; then
    stop_all
fi

exit 0

