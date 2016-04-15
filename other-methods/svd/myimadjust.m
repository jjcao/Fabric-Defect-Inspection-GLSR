function [B1,B2]=myimadjust(A)
B1=abs(A);
% [m,n]=size(A);
%    MIN=min(min(A));
%     MAX=max(max(A));
%     for i=1:m
%         for j=1:n
%             A(i,j)=A(i,j)-MIN;
%             B(i,j)=A(i,j)*255/(MAX-MIN);
%         end
%     end
% B=B>9*mean2(B);  %defect9 shi 9

B2=B1>6.5*mean2(B1);  %defect9 shi 9
    
        