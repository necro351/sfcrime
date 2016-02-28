Logistic regression of SF crime
    
Use a simple logistic regression with 6 features to classify into 39 different
crime classes. Also includes plotting code and a python parser to convert the
CSV format into a numeric matrix that can be manipulated in Octave.

1) Put the training data in a file named 'train.csv' and remove the first line
with the column names.

2) Run ./clean.py and redirect output to train.data, e.g.:
   ./clean.py>train.data

3) Run octave and sfcrime, e.g.:
   octave
   sfcrime
