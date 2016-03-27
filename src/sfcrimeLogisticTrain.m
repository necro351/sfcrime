load /data/sfcrime/trainingSet;

thetas = logisticTrain(X, classes, numCrimes);

save -binary /data/sfcrime/trainedLogisticModel thetas
