function A = myLDA(Samples, Labels, NewDim)
% Input:
%   Samples: The Data Samples
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA


	[NumSamples NumFeatures] = size(Samples);
  A=zeros(NumFeatures,NewDim);

    NumLabels = length(Labels);
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes);  %The number of classes

    %For each class i
	%Find the necessary statistics


  Sw = zeros(NumFeatures, NumFeatures);
  Sb=zeros(NumFeatures, NumFeatures);
    for i = 1:NumClasses
        % Calculate the Class Prior Probability
        P(i) = sum(Labels == Classes(i)) / NumSamples;
        % Calculate the Class Means
        mu(i,:) = mean(Samples(Labels == Classes(i),:));
        % Calculate the Within-Class Scatter Matrix Sw
        Xi = Samples(Labels == Classes(i),:);
        Xi = Xi - mu(i,:);
        Si = (Xi' * Xi) / (length(Xi) - 1);
        Sw = Sw + Si;
        % Calculate the Between-Class Scatter Matrix Sb
        mui = mu(i,:)' - mean(mu)';
        Sb = Sb + P(i) * (mui * mui');
    end
    %Calculate the Global Mean
	  m0=mean(Samples);

    %Perform Eigendecomposition
    [V, D] = eig(inv(Sw)*Sb);

    %Select the NewDim eigenvectors corresponding to the top NewDim
    %eigenvalues (Assuming they are NewDim<=NumClasses-1)
	  %% You need to return the following variable correctly.
	  A=zeros(NumFeatures,NewDim);  % Return the LDA projection vectors

    %Select the NewDim eigenvectors corresponding to the top NewDim eigenvalues
    if NewDim >= NumClasses-1
        NewDim = NumClasses-1;
    end
   %Sort eigenvalues and eigenvectors in decreasing order of eigenvalues
    [~, idx] = sort(diag(D), 'descend');
    V = V(:,idx);

    A = V(:,1:NewDim);
