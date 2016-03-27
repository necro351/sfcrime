% This code is based on Andrew Ng's machine learning course exercise on neural
% nets.

load /data/sfcrime/trainingSet;

% Setup the parameters
input_layer_size  = size(X,2);  % time, location, etc..., features
hidden_layer_size = 25;         % 25 hidden units
num_labels = max(classes) + 1;  % usually 39 labels, but often 1 or 2 less

% Initialize the edge weights
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters into a single vector
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

% Configure parameters for learning
options = optimset('MaxIter', 50);
lambda = 1;

% Convert classes to one-hot-vectors for neural net
y = zeros(size(classes, 1), num_labels);
for i = 1:size(classes, 1)
   % Maps 0 to 1, 1 to 2, ..., 39 to 40
   y(i,classes(i) + 1) = 1;
end

% Create "short hand" for the cost function to be minimized
costFunction = @(p) neuralCostFunction(p, ...
                                       input_layer_size, ...
                                       hidden_layer_size, ...
                                       num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

save -binary /data/sfcrime/trainedNeuralModel Theta1 Theta2
