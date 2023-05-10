function [Z] = projectDataLDA(X, v)

% You need to return the following variables correctly.
Z = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================

% Project the data onto the optimal direction for maximum class separation
Z = X * v;

% =============================================================

end
