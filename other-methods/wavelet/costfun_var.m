function f=costfun_var(x,p)
%%%%%%%%%%%%%%%%%%%%%
%x the lowpass filter
%p the section of the texture 
%%%%%%%%%%%%%%%%%%%
% [m,n]=size(p);
% N=16;
% % for i=1:N
% % y(i) = (-1)^(-N/2+1+i-1)*x(N-i+1);%the lowpass filter corresponding to x
% % end
% p_1=conv2(x,x,p,'same');%low frenquence compoment
% p_mean=mean2(p_1);
% p_var=0;
% for i=1:m
%     for j=1:n
%         p_var=p_var+(p_1(i,j)-p_mean)^2;
%     end
% end
% f=1.0/p_var;
[m,n]=size(p);
N=16;
% for j=1:N
%    x1(j)=(-1)^(j+1)*x(N-j+1);
%    end
p_1=conv2(x,x,p,'same');%low frenquence compoment
p_mean=mean2(p_1);  %矩阵的平均值
p_var=0;
for i=1:m
    for j=1:n
        p_var=p_var+(p_1(i,j)-p_mean)^2;
    end
end
f=p_var;

        
