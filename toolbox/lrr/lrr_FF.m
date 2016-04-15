function [Z,E] = lrr_FF(X  , patch_prior , lambda)
% This routine solves the following nuclear-norm optimization problem 
% by using inexact Augmented Lagrange Multiplier, which has been also presented 
% in the paper entitled "Robust Subspace Segmentation 
% by Low-Rank Representation".
%------------------------------
% min |Z|_*+lambda*|E|_2,1
% s.t., X = XZ+E
%--------------------------------
% inputs:
%        X -- D*N data matrix, D is the data dimension, and N is the number
%             of data vectors.
if nargin<2
    lambda = 1;
end
tol = 1e-3;
maxIter = 1e3;
[d n] = size(X);
rho = 1.1;
% max_mu = 1e30;
max_mu = 1e6;%做了改动，原来是le30
mu = 1e-6;
xtx = X'*X;
%% Initializing optimization variables
% intialize
Z = zeros(n,n);
E = sparse(d,n);

Y1 = zeros(d,n);
%% Start main loop
iter = 0;
DEBUG = 0;
if DEBUG
disp(['initial,rank=' num2str(rank(Z))]);
end
prior_matrix = diag( patch_prior) ; ptp = prior_matrix * prior_matrix' ;
while iter<maxIter
    iter = iter + 1;
    
    Z = inv( 2 * eye(n) + mu*xtx ) * ( X'*Y1 - mu*X'*E + mu*xtx);
    
    xmaz = X-X*Z;
    E = (mu*X + Y1 - mu*X*Z)  * inv(2*lambda*ptp + mu*eye(n));
    
    leq1 = xmaz-E;
    stopC = max(max(abs(leq1)));
    if DEBUG
    if iter==1 || mod(iter,50)==0 || stopC<tol
        disp(['iter ' num2str(iter) ',mu=' num2str(mu,'%2.1e') ...
            ',rank=' num2str(rank(Z,1e-3*norm(Z,2))) ',stopALM=' num2str(stopC,'%2.3e')]);
    end
    end
    if stopC<tol 
        break;
    else
        Y1 = Y1 + mu*leq1;
        mu = min(max_mu,mu*rho);
    end
end

function [E] = solve_l1l2(W,lambda)
n = size(W,2);
E = W;
for i=1:n
    E(:,i) = solve_l2(W(:,i),lambda);
end


function [x] = solve_l2(w,lambda)
% min lambda |x|_2 + |x-w|_2^2
nw = norm(w);
if nw>lambda
    x = (nw-lambda)*w/nw;
else
    x = zeros(length(w),1);
end