function [fea_lbp,patch_id]=constructLBP(im,n,m,field,way)  %得到n*m个patch的直方图，以及每个像素的id
[H,W]=size(im);
mapping=getmapping(field,way);
maxpattern=mapping.num;
subH=fix(H/n);  %patch的长度
subW=fix(W/m);   %patch的 宽度
% if strcmp(way,'u2') %Uniform 2
%     maxpattern=59;
% end
% if strcmp(way,'ri') %Uniform 2
%     maxpattern=39;
% end
%  if strcmp(way,'riu2') %Uniform 2
%     maxpattern=10;
%  end
fea_lbp=zeros(maxpattern,n*m);  % is the number of histograms bins on each sub-block 子块 直方图有59个纵列 最大值是58
patch_id=zeros(size(im));
subI=zeros(subH,subW);

p=1;
for i=0:n-1
    for j=0:m-1
        subI=im(i*subH+1:(i+1)*subH,j*subW+1:(j+1)*subW);           %第i个patch
        c=i*subH+1:(i+1)*subH;d=j*subW+1:(j+1)*subW;
        patch_id(c,d)=p*ones(subH,subW);
        % mapping=getmapping(field,way);
        subHist=lbp(subI,1,field,mapping,'nh')';
        if i==0&j==0
            hist=subHist;
        else
            hist=[hist,subHist];
        end
        p=p+1;
    end
end
fea_lbp=hist;