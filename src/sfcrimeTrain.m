load trainingSet;

thetas = train(X, classes, numCrimes);

save -binary trainedModel thetas
