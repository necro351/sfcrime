%% Initialization
%clear ; close all; clc

% Read in the training data
load

% Add features
fprintf('Adding indicator variables for time features\n');
fflush(stdout);
timeFeatures = addTimeFeatures(data(:,1));
precinctFeatures = addClassFeatures(data(:,3));
%blockFeatures = addClassFeatures(data(:,4));
%streetFeatures = addClassFeatures(data(:,5));
crimes = data(:,7);
%data = [timeFeatures, precinctFeatures, blockFeatures, streetFeatures, crimes];
data = [timeFeatures, precinctFeatures, crimes];

% Feature scale the data
%fprintf('Feature scaling data\n');
%fflush(stdout);
%scaledData = featureScale(data);

% TODO: Divide the training data into train, _CV_, and test
% TODO: Divide the training data into train and test

X = data(:,1:size(data, 2) - 1);
classes = data(:,size(data, 2));

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

