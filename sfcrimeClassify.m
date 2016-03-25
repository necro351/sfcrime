load trainingSet
load trainedModel

predictedCrimes = logisticClassify(thetas, X);
accuracy = predictedCrimes == classes;
accuracy = sum(accuracy)/size(accuracy,1);
fprintf('Predicted against train set with %f%% accuracy\n', accuracy*100);
fflush(stdout);
