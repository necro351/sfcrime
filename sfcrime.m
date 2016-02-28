% Initialization
clear ; close all; clc

% Read in the training data
fprintf('Loading the data into Octave\n');
fflush(stdout);
data=csvread('train.data');
crimes;
% The columns of the train data are:
% 1     2    3         4      5       6       7       8
% time, day, district, block, street, gpslat, gpslon, crime
% ...where day, district, block, street, and crime are category integers
numCrimes = max(data(:,size(data, 2))) + 1;

% Add features
fprintf('Adding indicator variables for engineered features\n');
fflush(stdout);
timeFeatures = addTimeFeatures(data(:,1));
precinctFeatures = addClassFeatures(data(:,3));
%blockFeatures = addClassFeatures(data(:,4));
%streetFeatures = addClassFeatures(data(:,5));
landmarkFeatures = addLandmarkFeatures(data(:, 6:7));
landmarkFeatures = featureScale(landmarkFeatures);
crimes = data(:,size(data, 2));
%data = [timeFeatures, precinctFeatures, blockFeatures, streetFeatures, crimes];
data = [timeFeatures, precinctFeatures, landmarkFeatures, crimes];

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
% TODO: Run the model on the test data and generate a submission
