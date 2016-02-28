function [features] = addClassFeatures(classes)
%ADDCLASSFEATURES Given a vector of N classes, convert each numerical class
%value into a one-hot-vector of indicator variables. Assume the largest found
%class value is the total number of classes.
   maxClass = max(classes);
   features = zeros(length(classes), maxClass + 1);
   for i = 1:length(classes)
      features(i, classes(i) + 1) = 1;
   end
end

