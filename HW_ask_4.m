clear all;
close all;

pkg load statistics

X = [1 0 1 ; -1 1 0]

[U,S,V] = svd(X)



%Result U,S,V from theory
U = [1/sqrt(2) 1/sqrt(2) ; -1/sqrt(2) 1/sqrt(2)]
S = [sqrt(3) 0 0 ; 0 1 0]
V = [sqrt(6)/3 0 1/sqrt(3); -sqrt(6)/6 1/sqrt(2) 1/sqrt(3); sqrt(6)/6 1/sqrt(2) -1/sqrt(3)]


%Approximate X
X_approximate =  U * S * transpose(V)

%Rank-k(k=1) approximation
k = 1;transpose(V);
rank_k_approximate = U(:,1:k)*S(1:k,1:k)*transpose(V(:,1:k))
