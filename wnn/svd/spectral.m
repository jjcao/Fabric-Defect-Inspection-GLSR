%%Read image from file

clear
clc
inimg=imread('start_5.png');
inimg=im2double(inimg(:,:,1));  %转化为double精度 1600*1200
% histeq(inimg,2) 柱状图
inimg=imresize(inimg,32/size(inimg,2));
% imshow(inimg);
%缩小了64/size（inimg,2）倍;imshow(inimg);
%   returns an image that is M times the
%    size of A. If M is between 0 and 1.0, B is smaller than A. If
%   M is greater than 1.0, B is larger than A. If METHOD is
%   omitted,IMRESIZE uses nearest neighbor interpolation
%%spectral residual
myFFT=fft2(inimg); %傅里叶变换 a+bi 与inimg同维；
mylogamplitude=log(abs(myFFT));%振幅转化到对数谱空间
myphase=angle(myFFT);%谱相图
myspecturalresidual=mylogamplitude-imfilter(mylogamplitude,fspecial('average',3),'replicate');  %进行滤波处理replicate Input array values outside the bounds of the array     are assumed to equal the nearest array border  value.                
saliencymap=abs(ifft2(exp(myspecturalresidual+i*myphase))).^2;
%%after effect
saliencymap=mat2gray(imfilter(saliencymap,fspecial('gaussian',[10,10],2)));% %对矩阵的归一化0表示黑 1表示白 imfilter是加个滤波器
% imshow(saliencymap,[]);title('defect12j.png')
% figure(2);
rsaliency=mean2(saliencymap);
bitsaliencymap=saliencymap>=2*rsaliency;
% for i=1:m

%     for j=1:n
%         if(saliencymap(i,j)>=2.5*rsaliency)
%             saliencymap(i,j)=1;
%         else
%             saliencymap(i,j)=0;
%         end
%     end
% end
%imshow(bitsaliencymap,[]);title('defect12j.png')
%imshow(inimg,[]);
%subplot(1,2,1);imshow(inimg,[]);title('defect6j.png')
 subplot(1,2,1);imshow(saliencymap,[]); %title('defect10j.png')
subplot(1,2,2);imshow(bitsaliencymap,[]);%title('defect10j.png')

