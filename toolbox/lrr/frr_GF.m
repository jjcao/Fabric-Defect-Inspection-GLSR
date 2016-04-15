%
% fixed-rank representation
% --------------------------
% min 1/2|Z-LR|^2 + mu|E|_1
% s.t. X = XZ + E
% --------------------------
% inputs:
%     X -- D*N data matrix, D is the data dimension, and N is the number of
%     data vector
%     m -- the approximation dimension for L and R, e.g., L in R^n*m and R
%     in R^m*n
%     flag -- normalization flag 1: do normalization 0: do not
%
% by Risheng Liu at 10/04/2011
function [Z, L, R, E] = frr_GF(X, m, mu , patch_prior)

if nargin < 4
    flag = 0;
end

if nargin < 3
    mu = 1;
end
if nargin < 2
    m = rank(X);
end

tol = 1e-6;
maxIter = 1e3;
[d, n] = size(X);
rho = 1.5;
max_beta = 1e30;
beta = 1e-6;
I = eye(n);
xtx = X'*X;


%% Initializing optimization variables
% intialize

L = zeros(n, m);
R = eye(m, n);
Z = zeros(n, n);
E = sparse(d,n);
Y = zeros(d, n);

%% Start main loop
iter = 0;
convergenced  = 0;
prior_matrix = diag( patch_prior) ; ptp = prior_matrix * prior_matrix' ;
while iter < maxIter
    
    iter = iter + 1;

    % update L
    [L,~] = qr(Z*R',0);

    % update R
    R = L'*Z;
    
    % update Z
    Z = inv(I + beta*xtx)*(L*R + beta*xtx - X'*(beta*E - Y));
    
    % update E
    xmxz = X - X*Z;
    E = (beta*X + Y - beta*X*Z)  * inv(2*mu*ptp + beta*eye(n));
    
    leq = xmxz - E;
    relErr = max(max(abs(leq)));
    convergenced = relErr < tol;
    
    if iter == 1 || mod(iter, 50)==0 || convergenced
        disp(['iter ' num2str(iter) ', beta = ' num2str(beta, '%2.1e')...
            ', relErr = ' num2str(relErr,'%2.3e')]);
    end
      
    if convergenced
        break;
    else
        Y = Y + beta*leq;
        beta = min(max_beta,beta*rho);
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


