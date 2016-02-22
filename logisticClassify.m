function [predictedCrimes] = logisticClassify(thetas, X)
%CHECK Classify each training example row in X given the logistic regression
%      model in thetas.
   classConfidences = sigmoid(X * thetas);
   [v, i] = max(classConfidences');
   predictedCrimes = i';
   predictedCrimes = predictedCrimes .- 1;
end

