function [T,DL,copyDpatch_id,Dpatch_id,defectid]=modifymain1(img,Wd,r,wm1,way,toversize,oversize)   %wm 为几个邻域
I=imread(img);
I=double(I(:,:,1));
imshow(I,[]);
h=get(0,'CurrentFigure');
rect=getrect(h);
xmin = double(rect(1));%列最小
ymin = double(rect(2));%行最小
width = double(rect(3));%宽度
height =double(rect(4));%高度
section = I(ymin:ymin+height,xmin:xmin+width);%纹理好的部分
M1=featureM(section,r,wm1,way);
%[S,patch_id,record]=windowfeatureS(section,Wd,wm,way);
[S1,patch_id,record]=windowfeaturepatteren(section,r,wm1,Wd,toversize );
L1=loglike(M1,S1);
L=L1
T=max(L);
%[DS,Dpatch_id,Drecord]=windowfeatureS(I,Wd,wm,way) ;
[DS1,Dpatch_id,Drecord]=windowfeaturepatteren(I,r,wm1,Wd,oversize) ;
DL=loglike(M1,DS1);
defectid=find(DL>T);
number=length(Drecord);
copyDpatch_id=Dpatch_id;
c=length(defectid);
        for k=1:number
             flag=0;
            for l=1:c
              if(Drecord(k).num==defectid(l))
                flag=1;
              end
            end
             if(flag==1)
            D(Drecord(k).row,Drecord(k).column)=ones(length(Drecord(k).row),length(Drecord(k).column));
               else
            D(Drecord(k).row,Drecord(k).column)=zeros(length(Drecord(k).row),length(Drecord(k).column));
             end
        end
    imshow(I,[]);    figure(2)
    imshow(D,[]);




% imshow(S,[]);
% figure(2);
% imshow(patch_id,[]);


% [DS,Dpatch_id,DK]=windowfeature(I,Wd,wm,way) %得到Sk
% DL=loglike(M,DS)
% saliency=process(DL,Dpatch_id,T);
% imshow(saliency,[]);

