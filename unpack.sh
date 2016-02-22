#!/bin/bash

# Unpack the train data, parse it, and dump the matrix into a CSV file
gunzip -c train.csv.gz|./clean.py>train.data
