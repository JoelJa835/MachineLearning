close all;
clear;
clc;
pkg load image;

data_file = './data/mnist.mat';

data = load(data_file);

% Read the train data
[train_C1_indices, train_C2_indices,train_C1_images,train_C2_images] = read_data(data.trainX,data.trainY.');

% Read the test data
[test_C1_indices, test_C2_indices,test_C1_images,test_C2_images] = read_data(data.testX,data.testY.');

%% Compute Aspect Ratio
% Compute aspect ratio of each image in C1 and C2 in train set
aRatio_C1_train = zeros(size(train_C1_images,1),1);
aRatio_C2_train = zeros(size(train_C2_images,1),1);
for i = 1:size(train_C1_images,1)
    aRatio_C1_train(i) = computeAspectRatio(squeeze(train_C1_images(i,:,:)));
end
for i = 1:size(train_C2_images,1)
    aRatio_C2_train(i) = computeAspectRatio(squeeze(train_C2_images(i,:,:)));
end

% Compute aspect ratio of each image in C1 and C2 in test set
aRatio_C1_test = zeros(size(test_C1_images,1),1);
aRatio_C2_test = zeros(size(test_C2_images,1),1);
for i = 1:size(test_C1_images,1)
    aRatio_C1_test(i) = computeAspectRatio(squeeze(test_C1_images(i,:,:)));
end
for i = 1:size(test_C2_images,1)
    aRatio_C2_test(i) = computeAspectRatio(squeeze(test_C2_images(i,:,:)));
end

% Compute the aspect ratios of all images and store the value of the i-th image in aRatios(i)

min_aspect_ratioC1train = min(aRatio_C1_train);
max_aspect_ratioC1train = max(aRatio_C1_train);
min_aspect_ratioC1test = min(aRatio_C1_test);
max_aspect_ratioC1test = max(aRatio_C1_test);
min_aspect_ratioC2train = min(aRatio_C2_train);
max_aspect_ratioC2train = max(aRatio_C2_train);
min_aspect_ratioC2test = min(aRatio_C2_test);
max_aspect_ratioC2test = max(aRatio_C2_test);


fprintf('Minimum aspect ratio of C1 train: %.2f\n', min_aspect_ratioC1train);
fprintf('Maximum aspect ratio of C1 train: %.2f\n', max_aspect_ratioC1train);
fprintf('Minimum aspect ratio of C1 test: %.2f\n', min_aspect_ratioC1test);
fprintf('Maximum aspect ratio of C1 test: %.2f\n', max_aspect_ratioC1test);
fprintf('Minimum aspect ratio of C2 train: %.2f\n', min_aspect_ratioC2train);
fprintf('Maximum aspect ratio of C2 train: %.2f\n', max_aspect_ratioC2train);
fprintf('Minimum aspect ratio of C2 test: %.2f\n', min_aspect_ratioC2test);
fprintf('Maximum aspect ratio of C2 test: %.2f\n', max_aspect_ratioC2test);


% Plot image with bounding parallelogram for one example from class 1 in the training set
image = squeeze(train_C1_images(65,:,:));
plotImageWithParallelogram(image);
title('Class 1 - Training');

% Plot image with bounding parallelogram for one example from class 2 in the training set
image = squeeze(train_C2_images(30,:,:));
plotImageWithParallelogram(image);
title('Class 2 - Training');




%% Bayesian Classifier


% Prior Probabilities


%num_train_C1 = size(train_C1_images, 1);
%num_train_C2 = size(train_C2_images, 1);
%num_test_C1 = size(test_C1_images, 1);
%num_test_C2 = size(test_C2_images, 1);

%% Compute a priori probabilities
num_train_C1 = length(train_C1_indices);
num_train_C2 = length(train_C2_indices);
%num_test_C1 = length(test_C1_indices);
%num_test_C2 = length(test_C2_indices);

P_C1_train = num_train_C1 / (num_train_C1 + num_train_C2);
P_C2_train = num_train_C2 / (num_train_C1 + num_train_C2);

%P_C1_test = num_test_C1 / (num_test_C1 + num_test_C2);
%P_C2_test = num_test_C2 / (num_test_C1 + num_test_C2);

fprintf('P(C1) for training set: %.2f\n', P_C1_train);
fprintf('P(C2) for training set: %.2f\n', P_C2_train);
%fprintf('P(C1) for test set: %.2f\n', P_C1_test);
%fprintf('P(C2) for test set: %.2f\n', P_C2_test);

% Likelihoods
m1 = mean(aRatio_C1_test);
m2 = mean(aRatio_C2_test);
sigma1 = std(aRatio_C1_test);
sigma2 = std(aRatio_C2_test);
PgivenC1 = @(x) normpdf(x, m1, sigma1);
PgivenC2 = @(x) normpdf(x, m2, sigma2);

% Posterior Probabilities
PC1givenL = @(x) P_C1_train * PgivenC1(x);
PC2givenL = @(x) P_C2_train * PgivenC2(x);

% Classification result
% BayesClass1 is correct when is equal to 1
BayesClass1 = 1*(PC1givenL(aRatio_C1_test(:,:))>=PC2givenL(aRatio_C1_test(:,:))) +2*(PC1givenL(aRatio_C1_test(:,:)) <PC2givenL(aRatio_C1_test(:,:)));

% BayesClass2 is correct when is equal to 2
BayesClass2 = 2*(PC2givenL(aRatio_C2_test(:,:))>=PC1givenL(aRatio_C2_test(:,:))) + 1*(PC2givenL(aRatio_C2_test(:,:))<PC1givenL(aRatio_C2_test(:,:)));


% Count misclassified digits
count_errors = sum(BayesClass1 == 2) + sum(BayesClass2 == 1);
% Count correct digits
count_correct = sum(BayesClass1 == 1) + sum(BayesClass2 == 2);


% Total Classification Error (percentage)
Error = (count_errors / (count_errors + count_correct)) * 100;


fprintf('Count misclassified digits: %.2f\n', count_errors);
fprintf('Count correct digits: %.2f\n', count_correct);
fprintf('Total Classification Error: %.2f\n', Error);




