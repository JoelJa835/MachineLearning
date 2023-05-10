function [X_rec] = recoverDataLDA(Z, v)

% You need to return the following variables correctly.
X_rec = zeros(size(Z, 1), length(v));

% ====================== YOUR CODE HERE ======================

% Recover the data in the original 2D space
X_rec = Z * v';

% =============================================================

end
