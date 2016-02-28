#!/bin/bash

# Unpack the train data, parse it, and dump the matrix into a CSV file
gunzip train.csv.gz
./clean.py>train.data
