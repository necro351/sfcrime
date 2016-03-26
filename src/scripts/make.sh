#!/bin/bash

if [ "$#" != "1" ]; then
   echo "help: Valid commands are:"
   echo "  parsetrain    Unpack the training data, parse it, and store the"
   echo "                result as a CSV file"
   echo "  clean         Remove all files created by running parser or octave"
   echo "                scripts"
   exit 1
fi

COMMAND="$1"

if [ "$COMMAND" = "parsetrain" ]; then
   # Unpack the train data, parse it, and dump the matrix into a CSV file
   zcat data/train.csv.gz|./clean.py>data/train.data
fi

if [ "$COMMAND" = "clean" ]; then
   # Remove files created from running parser and octave scripts
   rm -f trainedModel
   rm -f trainingSet
   rm -f data/train.data
fi
