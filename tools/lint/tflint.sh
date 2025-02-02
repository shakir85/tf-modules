#!/bin/bash

export TFLINT_LOG=debug

tflint --init
if [ $? -ne 0 ]; then
  echo "Failed to initialize tflint"
  exit 1
fi

tflint
