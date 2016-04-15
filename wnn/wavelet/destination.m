function f = destination(x,p)
%参见<texture chatacterization and defect
%      detection using adaptive wavelets> warren J.Jasper & Stephen
%      J.Gamier.
f = x*p'*(p*x');%小波变换；
% [m,n]=size(x);
% f=0;
% for i=1:m
%     for j=1:n
%     f=f+(x(i,j)-t(i,j))^2;
%    end
% end
% f = x*p'*p*x';
 %I = imread('img_dest.jpg');