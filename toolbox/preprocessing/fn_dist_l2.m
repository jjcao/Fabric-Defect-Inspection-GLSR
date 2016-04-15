function D = fn_dist_l2(P1, P2)

% Euclidian distances between vectors
% P1, P2 : [n p] where n: # of data, p: # of dimension

if nargin == 2
    X1=repmat(sum(P1.^2,2), [1 size(P2,1)]);
    X2=repmat(sum(P2.^2,2), [1 size(P1,1)]);
    R=P1*P2';
    D=X1+X2'-2*R;
else
    % each vector is one column
    X1=repmat(sum(P1.^2,1),[size(P1,2) 1]);
    R=P1'*P1;
    D=X1+X1'-2*R;
end

D = sqrt(D);
