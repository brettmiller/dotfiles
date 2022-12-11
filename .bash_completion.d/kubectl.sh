#!/bin/bash

if command -v kubectl; then
  TMPKCB=/tmp/KCB${RANDOM}
  
  kubectl completion bash > $TMPKCB
  
  . $TMPKCB
  rm $TMPKCB
fi
