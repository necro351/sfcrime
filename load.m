fprintf('Loading the data into Octave\n');
fflush(stdout);
data=csvread('train.data');
crimes;
% The columns of the train data are:
% 1     2    3         4        5       6       7
% time, day, district, address, gpslat, gpslon, crime
% ...where day, district, address, and crime are category integers
numCrimes = max(data(:,7)) + 1;
numDistricts = max(data(:,3)) + 1;
numAddresses = max(data(:,4)) + 1;
numDays = 7;
numFeatures = 6;
