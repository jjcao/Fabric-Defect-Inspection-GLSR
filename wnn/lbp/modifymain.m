function [T,DL,copyDpatch_id,Dpatch_id,defectid]=modifymain(img,Wd,r1,r2,wm1,wm2,way,toversize,oversize , thre_muls)   %wm 为几个邻域


dot_id = strfind( img , '.') ; sprit_id = strfind( img , '\') ;
name = img(sprit_id(end) + 1 : dot_id(end) - 1);
write_patch = '..\all_results\';

I=imread(img);
write_name = [write_patch name '_original.png'];
 imwrite( I , write_name);
imshow(I , []) ;
[m , n , chs] = size(I) ;
 if chs > 1
     I = rgb2gray(I) ;
 else
     I = I;
 end

% write_name = [write_patch name '_original' '.png'];
% imwrite( I , write_name);
imshow(I,[]);

I=double(I);
h=get(0,'CurrentFigure');
rect=getrect(h);
xmin = double(rect(1));%列最小
ymin = double(rect(2));%行最小
width = double(rect(3));%宽度
height =double(rect(4));%高度
section = I(ymin:ymin+height,xmin:xmin+width);%纹理好的部分
% section = imread('C:\Users\CGGI008\Desktop\zj\my computer\D\blemish detection\experiment\data\box-patterned-fabric_with_groundtruth\Reference\Bbox_p10.bmp');
M1=featureM(section,r1,wm1,way) ;
M2=featureM(section,r2,wm2,way) ;
%[S,patch_id,record]=windowfeatureS(section,Wd,wm,way);
[S1,patch_id,record]=windowfeaturepatteren(section,r1,wm1, Wd ,toversize );
[S2,patch_id,record]=windowfeaturepatteren(section,r2,wm2, Wd ,toversize );
% L1=loglike(M1,S1);  %多尺度
% L2=loglike(M2,S2);
L1 = sum( (S1 - repmat(M1, 1 ,size(S1 , 2))) .^ 2 );
L2 = sum( (S2 - repmat(M2, 1 ,size(S2 , 2))) .^ 2 );
L=L1+L2;
%[DS,Dpa5tch_id,Drecord]=windowfeatureS(I,Wd,wm,way) ;
[DS1,Dpatch_id,Drecord]=windowfeaturepatteren(I,r1, wm1,Wd,oversize) ;
[DS2,Dpatch_id,Drecord]=windowfeaturepatteren(I,r2, wm2,Wd,oversize) ;
DL1=loglike(M1,DS1);
DL=DL1+loglike(M2,DS2);
DL1 = sum( (DS1 - repmat(M1, 1 ,size(DS1 , 2))) .^ 2 );
DL = DL1 + sum( (DS2 - repmat(M2, 1 ,size(DS2 , 2))) .^ 2 );
for thre_mul = thre_muls
    T = thre_mul * max(L);
    D = zeros(m , n);
    D1 = zeros(m , n);
    
    defectid=find(DL>T);  %确界
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
        D(Drecord(k).row,Drecord(k).column) = D(Drecord(k).row,Drecord(k).column) + DL(k)*ones(length(Drecord(k).row),length(Drecord(k).column));
        if(flag==1)
            D(Drecord(k).row,Drecord(k).column)=DL(k)*ones(length(Drecord(k).row),length(Drecord(k).column));
            D1(Drecord(k).row,Drecord(k).column)=ones(length(Drecord(k).row),length(Drecord(k).column));
%         else
%             D(Drecord(k).row,Drecord(k).column)=zeros(length(Drecord(k).row),length(Drecord(k).column));
%             D1(Drecord(k).row,Drecord(k).column)=zeros(length(Drecord(k).row),length(Drecord(k).column));
        end
    end
    
    write_name_saliencymap = [write_patch name 'lbp_10_' num2str(Wd) '_' num2str(r1) '_' num2str(r2) '_' num2str(wm1) '_' num2str(wm2) '_' way '_' num2str(toversize) '_' num2str(oversize) '.png'];
    imwrite( mat2gray(D) , write_name_saliencymap);
    
    write_name = [write_patch name 'lbp_10_' num2str(Wd) '_' num2str(r1) '_' num2str(r2) '_' num2str(wm1) '_' num2str(wm2) '_' way '_' num2str(toversize) '_' num2str(oversize) '_' num2str(thre_mul * 10000) '.png'];
    imwrite( mat2gray(D1) , write_name);
    clear T defectid copyDpatch_id d D1
end
%     imshow(I,[]);    figure(2)
%     subplot(1,2,1);imshow(D,[]);title(' lbp saliency ')
%     subplot(1,2,2);imshow(D1,[]);title(' lbp bitsaliency ')




% imshow(S,[]);
% figure(2);
% imshow(patch_id,[]);


% [DS,Dpatch_id,DK]=windowfeature(I,Wd,wm,way) %得到Sk
% DL=loglike(M,DS)
% saliency=process(DL,Dpatch_id,T);
% imshow(saliency,[]);

