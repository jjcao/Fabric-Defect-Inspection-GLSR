%此函数是约束条件中的  Cm(c) = sum(c(k)c(k-2m)) - deta(0,m) =0;
%参见<texture chatacterization and defect
%      detection using adaptive wavelets> warren J.Jasper & Stephen
%      J.Gamier.
function f = sumk(x,m,N)   %my constraint function% orthonormality of a vector
f = 0;
% N = 16;
for k = 1:N-2*(m-1)
f = x(k)*x(k+2*(m-1))+f;
end
