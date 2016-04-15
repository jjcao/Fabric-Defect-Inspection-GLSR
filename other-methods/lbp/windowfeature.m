function [fea_lbp,patch_id,K,record]=windowfeature(img,Wd,wm,way) %得到Sk
[H,W]=size(img);
mapping=getmapping(wm,way);
maxpattern=mapping.num;
m=fix(H/(Wd/2));   %patch的长度
n=fix(W/(Wd/2));   %patch的 宽度
fea_lbp=zeros(maxpattern,n*m);  % is the number of histograms bins on each sub-block 子块 直方图有59个纵列 最大值是58
patch_id=zeros(size(img));
subI=zeros(Wd,Wd);
K=1;
    for i=0:m-2
        for j=0:n-2   
             subI=img(i*Wd/2+1:(i/2+1)*Wd,j*Wd/2+1:(1+j/2)*Wd);           %第i个patch
             c=i*Wd/2+1:(i/2+1)*Wd;    d=j*Wd/2+1:(1+j/2)*Wd;
             patch_id(c,d)=K*ones(Wd,Wd);
             record(K).row=c;
             record(K).column=d;
             record(K).num=K;
             %  mapping=getmapping(field,way);
            subHist=lbp(subI,4,wm,mapping,'nh')';
            if i==0&j==0
                hist=subHist;
            else
                hist=[hist,subHist];
            end
             K=K+1;
        end
        subI=img(i*Wd/2+1:(i/2+1)*Wd,(n-1)*Wd/2+1:end);           %第i个patch
             c=i*Wd/2+1:(i/2+1)*Wd;d=(n-1)*Wd/2+1:W;
             patch_id(c,d)=K*ones(Wd,W-(n-1)*Wd/2);
             record(K).row=c;
             record(K).column=d;
             record(K).num=K;
            subHist=lbp(subI,4,wm,mapping,'nh')';
               if i==0&j==0
                hist=subHist;
            else
                hist=[hist,subHist];
            end
             K=K+1;
    end
    for j=0:n-2
     subI=img((m-1)*Wd/2+1:end,j*Wd/2+1:(1+j/2)*Wd);     
             c=(m-1)*Wd/2+1:H; d=j*Wd/2+1:(1+j/2)*Wd;
             patch_id(c,d)=K*ones(H-(m-1)*Wd/2,Wd);
             record(K).row=c;
             record(K).column=d;
             record(K).num=K;
            subHist=lbp(subI,4,wm,mapping,'nh')';
               if i==0&j==0
                hist=subHist;
            else
                hist=[hist,subHist];
            end
             K=K+1;
    end
     subI=img((m-1)*Wd/2+1:end,(n-1)*Wd/2+1:end);     
             c=(m-1)*Wd/2+1:H; d=(n-1)*Wd/2+1:W;
             a=H-(m-1)*Wd/2;
             b=W-(n-1)*Wd/2;
             patch_id(c,d)=K*ones(a,b);
             record(K).row=c;
             record(K).column=d;
             record(K).num=K;
            subHist=lbp(subI,4,wm,mapping,'nh')';
               if i==0&j==0
                hist=subHist;
            else
                hist=[hist,subHist];
               end
    fea_lbp(:,:)=hist;
   % imshow(patch_id,[]);
