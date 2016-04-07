function [J grad] = neuralCostFunction(nn_params, ...
                                       input_layer_size, ...
                                       hidden_layer_size, ...
                                       num_labels, ...
                                       X, y, lambda)
%NEURALCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NEURALCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.

% Disable broadcasting warnings as we rely on broadcast to vectorize
warning ("off", "Octave:broadcast");

%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m

biasedX = [ones(m, 1) X];
Z2 = biasedX * Theta1';
A2 = sigmoid(Z2);
biasedA2 = [ones(m, 1) A2];
Z3 = biasedA2 * Theta2';
A3 = sigmoid(Z3);
yHat = A3';

% we use a trick to convert class labels to one-hot-vectors
% (i.e., 3 becomes [0; 0; 0; 1; ... 0] and
%        0 becomes [1; 0; 0; 0; ... 0]
yOneHot = ((zeros(length(y), num_labels) + ((1:num_labels) .- 1)) == y)';

J = 1/m*sum(sum(-yOneHot.*log(yHat) - (1 .- yOneHot).*log(1 .- yHat)));
J += lambda/(2*m)*(sum(sum(Theta1(:, 2:end).^2)) + ...
                   sum(sum(Theta2(:, 2:end).^2)));

%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.

Errors3 = yHat .- yOneHot;
Errors2 = Theta2'*Errors3.*sigmoidGradient([ones(1, size(Z2', 2)); Z2']);
% Delta(l)_i_j = Delta(l)_i_j + a(l)_j*error(l+1)_i
%
% We compute Deltas1 and Deltas2 by computing the complete accumulated value of
% Delta(l)_i_j across all training examples, before computing other Deltas,
% e.g., Delta(l)_i+1_j. By doing the accumulations in this order, we can use a
% matrix multiplication instead of looping through each training example.
Deltas2 = biasedA2'*Errors3';
Deltas1 = biasedX'*Errors2';

%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
% -------------------------------------------------------------
Theta1ZeroBias = Theta1;
Theta1ZeroBias(:, 1) = 0;
Theta2ZeroBias = Theta2;
Theta2ZeroBias(:, 1) = 0;
Theta2_grad = 1/m*Deltas2' + lambda/m*Theta2ZeroBias;
Theta1_grad = 1/m*(Deltas1(:, 2:end))' + lambda/m*Theta1ZeroBias;

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
