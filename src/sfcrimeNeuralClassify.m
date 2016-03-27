load /data/sfcrime/trainingSet
load /data/sfcrime/trainedNeuralModel

yHat = neuralClassify(Theta1, Theta2, X);

% Convert one-hot-vectors back to classes
predictedCrimes = yHat .- 1;

accuracy = predictedCrimes == classes;
accuracy = sum(accuracy)/size(accuracy,1);
fprintf('Predicted against train set with %f%% accuracy\n', accuracy*100);
fflush(stdout);

