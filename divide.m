fprintf('Dividing data into train and test set\n');
fflush(stdout);
trainData = zeros(size(data));
testData = zeros(size(data));
lenTrain = 1;
lenTest = 1;
for i = 1:rows(data)
   if mod(i, 5) < 4
      % 80% goes to training data
      trainData(lenTrain,:) = data(i,:);
      lenTrain += 1;
   else
      % 20% goes to testing data
      testData(lenTest,:) = data(i,:);
      lenTest += 1;
   end
end
trainData = trainData(1:lenTrain,:);
testData = testData(1:lenTest,:);

