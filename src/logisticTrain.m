function [thetas] = logisticTrain(X, classes, numCrimes)
%TRAIN Fit the logistic regression model theta(:,i) to the given training set
%      X,y for each class 'i' in y.
   % Use 1-vs-all logistic regression:
   % for each category, compute thetas
   crimeNames;
   fprintf('Fitting classifiers for each crime category...\n');
   fflush(stdout);
   numFeatures = size(X, 2);
   thetas = zeros(numFeatures, numCrimes);
   options = optimset('GradObj', 'on', 'MaxIter', 100);
   for i = 1:numCrimes
      y = classes == i - 1;
      %  Run fminunc to obtain the optimal theta
      %  This function will return theta and the cost 
      [theta, cost] = fminunc(@(t)(logisticCostFunction(t, X, y)), ...
                              thetas(:,i), options);
      thetas(:,i) = theta;
      fprintf('\t"%s" fit with cost %f\n', crimeNames(i,:), cost);
      fflush(stdout);
   end
end

