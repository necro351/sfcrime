%% Initialization
%clear ; close all; clc

% Read in the training data
load

% Feature scale the data
featureScale

% TODO: Divide the training data into train, _CV_, and test
% TODO: Divide the training data into train and test
%divide
% 
X = scaledData(:,1:numFeatures);
classes = scaledData(:,numFeatures + 1);

% Plot the train data
plot(data, crimes);

%X = trainData(:,1:numFeatures);
%classes = trainData(:,numFeatures + 1);
thetas = train(X, classes, numCrimes);

% Check accuracy against test data
%X = testData(:,1:numFeatures);
%classes = testData(:,numFeatures + 1);
predictedCrimes = logisticClassify(thetas, X);
accuracy = predictedCrimes == classes;
accuracy = sum(accuracy)/size(accuracy,1);
fprintf('Predicted against train set with %f%% accuracy\n', accuracy*100);
fflush(stdout);

% TODO: Use regularization
% TODO: Use cross-validation set to tune regularization
% TODO: Maybe try SVMs if logistic regression doesn't work

% Read in the test data
% for each test example, use all classifiers, pick the best 
% plot the predicted crimes for the given test data
% print the predicted crimes to the submission file

