#!/bin/bash

TMPKCB=/tmp/KCB${RANDOM}

kubectl completion bash > $TMPKCB

. $TMPKCB
rm $TMPKCB
