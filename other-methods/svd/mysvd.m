function [period,patternA,svdmodle,svdmap] = mysvd(img)
I=imread(img);
[~ , ~ , chs] = size(I) ;
 if chs > 1
     I = rgb2gray(I) ;
 end
 I = double(I) ;
%I=resize(i,64/size(i,2));
%I=imrotate(I,-270); %defect10j.png需要旋转
[row,column]=size(I);
x=reshape(I',1,row*column);%生成一个行向量作为信号x；按列取值
[U,S,V]=svds(I,2);  %先求出对原矩阵的分解 减少计算复杂度；
svdmodle=U(:,1)*S(1,1)*V(:,1)';
svdmap=I-svdmodle;
svdmap=myimadjust(svdmap);
maxp=1-S(2,2)/S(1,1);  %p-spectrum  用来求得最大值
period=1;
patternA=I;
p=[];
p(1)=maxp;
for k=2:row/4     %输入图像的row个行
    rowx=fix(row/k);
    A=zeros(rowx,k*column);
    for i=1:rowx   %重排；
        A(i,:)=x((k*i-k)*column+1:k*i*column);
    end
    if(mod(row,k)~=0)
        B=zeros(rowx+1,k*column);
       B(1:rowx,:)=A;
       B(rowx+1,:)=[x(k*rowx*column+1:end),A(rowx,((row-rowx*k))*column+1:end)];
       A=B;
    end
    [U,S,V]=svds(A,2);
    s=U(:,1)*S(1,1)*V(:,1)';
    if size(S,1)<=1
       break
    end
    p(k)=1-S(2,2)/S(1,1);  %p-spectrum  用来求得最大值
    if p(k)>maxp
        maxp=p;
        svdmodle=s;    
        period=k;
        patternA=A;
         period;
         maxp;
    end
end
[svdmodle,svdmap]=myreshape(I,svdmodle,period);
% subplot(2,2,1);imshow(I,[]);title('pattern');
% subplot(2,2,2);imshow(svdmodle,[]);title('svd modle');
% 
% subplot(2,2,3);imshow(svdmap,[]);title('residual');
% subplot(2,2,4);plot(p);axis([1 k min(p) 1]);ylabel('P-spectram');xlabel('low');
% figure(2);
% subplot(1,2,1);imshow(svdmap,[]);title(img);
% subplot(1,2,2);imshow(bitsvdmap,[]);title(img);

dot_id = strfind(img , '.') ; sprit_id = strfind(img , '\') ;
name = img(sprit_id(end) + 1 : dot_id(end) - 1);
write_patch = '..\all_results\';
write_name = [write_patch name 'svd' '.png'];
imwrite( mat2gray(svdmap) , write_name);

svdmap = mat2gray(svdmap) ;
level = graythresh( svdmap ) ;
saliency_map_bina = im2bw( svdmap , level );
write_name =  [write_patch name 'svd_bina' '.png'];
imwrite( saliency_map_bina , write_name);


    
        
        
    
    

