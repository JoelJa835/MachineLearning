clear all;
close all;

pkg load statistics

m1 = [3;3]
m2 = [6;6]

s1 = [1.2 -0.4 ; -0.4 1.2]
s2 = [1.2 0.4 ; 0.4 1.2]

p = 0.125

% The equation of the border
eq = @(x) transpose(x - m1) * inv(s1) * (x - m1) - transpose(x - m2) * inv(s2) * (x - m2) + 2*log( (1-p)/p * sqrt(det(s1)/det(s2)));

% Create the 2D grid
x1 = linspace(-1, 10, 100);
x2 = linspace(-1, 10, 100);
[X1, X2] = meshgrid(x1, x2);
grid_x = [X1(:) X2(:)];

% Plugging in the xs so we can draw the border
border = eq([x1(:) x2(:)]');

% Create the Gaussian pdfs
w1 = mvnpdf(grid_x, m1', s1);
w1 = reshape(w1, length(x1), length(x2));
w2 = mvnpdf(grid_x, m2', s2);
w2 = reshape(w2, length(x1), length(x2));

% Ploting the graphs.
figure;
contour(x1, x2, w1);
hold on;
contour(x1, x2, w2);
hold on;
% [0 0] is chosen because we want the line where eq equals to 0
contour(x1, x2, border, [0 0]);
legend('w1', 'w2', 'border');



