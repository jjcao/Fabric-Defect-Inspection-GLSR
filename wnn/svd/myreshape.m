function [svdmodle,svdmap]=myreshape(I,modle,period)
[m,n]=size(I);
% rowx=fix(m/period);
if(mod(m,period)==0)
    x=reshape(modle',1,m*n);
    svdmodle(1:m,:)=reshape(x,n,m)';
else
   [m1,n1]=size(modle);
   x=reshape(modle',1,m1*n1);
   x=x(1:m*n);
   svdmodle(1:m,:)=reshape(x,n,m)';
end
%C=svdmodle(1:rowx*period,:);
%svdmodle(rowx*period+1:m,:)=C(1:m-rowx*period,:);
svdmap=myimadjust(I-svdmodle);


