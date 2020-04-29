#!/bin/bash

set -e

function main() {
  sanitize "${INPUT_INSTANCE_IDS}" "instance-ids"
  sanitize "${INPUT_DOCUMENT_NAME}" "document_name"

  init
  send_command
}

function sanitize() {
  if [ -z "${1}" ]; then
    >&2 echo "${2} is required. Did you set parameter ${2}?"
    exit 1
  fi
}

function init() {
  export INSTANCE_IDS=$INPUT_INSTANCE_IDS
  export DOCUMENT_NAME=$INPUT_DOCUMENT_NAME
  export COMMENT=$INPUT_COMMENT
}

function send_command() {
  echo "== START SEND-COMMAND"

  eval "aws ssm send-command \
    --instance-ids ${INSTANCE_IDS} \
    --document-name ${DOCUMENT_NAME} \
    --comment '${COMMENT}'"

  echo "== FINISHED SEND_COMMAND"
}

main
