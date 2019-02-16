#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "No arguments supplied."
  printf "\t Usage: ./run-tests.sh [container_name]\n"
  exit 1
fi

container_name=$1

function syntax_check {
  docker exec $container_name env ANSIBLE_FORCE_COLOR=1 USER=dotfiles \
  ansible-playbook -v -i /opt/Workspace/dotfiles/inventory.local /opt/Workspace/dotfiles/site.yml --syntax-check \
  --extra-vars "clone_folder=/opt/Workspace";
}

function run_once {
  docker exec $container_name env ANSIBLE_FORCE_COLOR=1 USER=dotfiles \
  ansible-playbook -v -i /opt/Workspace/dotfiles/inventory.local /opt/Workspace/dotfiles/site.yml \
  --extra-vars "clone_folder=/opt/Workspace"
}

function idempotence_check {
  out=$(mktemp)
  run_once | tee ${out}
  grep -q 'changed=0.*failed=0' ${out} && (echo 'Idempotence test: pass' && return 0) || (echo 'Idempotence test: fail' && return 1)
}

syntax_check && run_once && idempotence_check