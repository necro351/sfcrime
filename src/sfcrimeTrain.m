load /data/sfcrime/trainingSet;

thetas = train(X, classes, numCrimes);

save -binary /data/sfcrime/trainedModel thetas
