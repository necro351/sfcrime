% Read in the training data
fprintf('Loading the data into Octave\n');
fflush(stdout);
data=csvread('train.data');
% The columns of the train data are:
% 1     2    3         4      5       6       7       8
% time, day, district, block, street, gpslat, gpslon, crime
% ...where day, district, block, street, and crime are category integers

% Add features
fprintf('Adding indicator variables for engineered features\n');
fflush(stdout);
timeFeatures = addTimeFeatures(data(:,1));
precinctFeatures = addClassFeatures(data(:,3));
landmarkFeatures = featureScale(addLandmarkFeatures(data(:, 6:7)));

X = [timeFeatures, precinctFeatures, landmarkFeatures];
classes = data(:,size(data, 2));
numCrimes = max(classes);

% Uncomment these commands to shrink the training set size down to only 10K
% training samples if you want training to run faster (e.g., because you are
% debugging something).
rndIDX = randperm(size(X,1)); 
X = X(rndIDX(1:10000),:);
classes = classes(rndIDX(1:10000),:);
numCrimes = max(classes);

save -binary trainingSet X classes numCrimes
