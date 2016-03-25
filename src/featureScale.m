function [scaledX] = featureScale(X)
%FEATURESCALE Given a vector of features X, scale them by their standard
%deviation, and translate them by their mean.
   means = mean(X);
   stds = std(X);
   scaledX = X;
   numFeatures = size(X)(2);
   for i = 1:numFeatures
      scaledX(:,i) = scaledX(:,i) .- means(:,i);
   end
   for i = 1:numFeatures
      scaledX(:,i) = scaledX(:,i) ./ stds(:,i);
   end
end
