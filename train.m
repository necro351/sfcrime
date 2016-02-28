function [thetas] = train(X, classes, numCrimes)
%TRAIN Fit the logistic regression model theta(:,i) to the given training set
%      X,y for each class 'i' in y.
   % Use 1-vs-all logistic regression:
   % for each category, compute thetas
   fprintf('Fitting classifiers for each crime category...\n');
   fflush(stdout);
   numFeatures = size(X, 2);
   thetas = zeros(numFeatures, numCrimes);
   options = optimset('GradObj', 'on', 'MaxIter', 400);
   for i = 1:numCrimes
      y = classes == i - 1;
      %  Run fminunc to obtain the optimal theta
      %  This function will return theta and the cost 
      [theta, cost] = fminunc(@(t)(costFunction(t, X, y)), ...
                              thetas(:,i), options);
      thetas(:,i) = theta;
      fprintf('\tCrime %d fit with cost %f\n', i - 1, cost);
      fflush(stdout);
   end
end

