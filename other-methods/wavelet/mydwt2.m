% function  h=mydwt2(img,T)   %T为对平滑图像二值化的阈值
% 
% % I=imread(img);
% % %  I=imread('15862.jpg');%羽毛
% % %I=imread('defect2_2.jpg'); 带有图案的效果不好了
% % %I=imread('pingwen.jpg');
% % I=double(rgb2gray(I));
% J=imread(img);
% [~ , ~ , chs] = size(J) ;
%  if chs > 1
%      I = rgb2gray(J) ;
%  else
%      I = J;
%  end
%  I = double(I) ;
% I=imresize(I,[256,256]);  %放大了I 或调整为256*256
% figure(1),title('original image');
% imshow(uint8(I),[]); %含某类疵点的图像%
% %%%%%length of filter%%%%%%%%%%
% N=8;             %截取无瑕疵的图像大小
% N1=8;
% %%%%%%%choose a section of the texture%%%%%%%%%% N*N
% h = get(0,'CurrentFigure');
% rect = getrect(h);
% xmin = floor(rect(1));%列最小
% ymin = floor(rect(2));%行最小
% width = floor(rect(3));%宽度
% height = floor(rect(4));%高度
% section = I(ymin:ymin+height,xmin:xmin+width);
% p=fabric_imgcut(section,N,N);
% %%%%%%%%%%%define the cost function%%%%%%%%%%%%%%
% %the cost function based on the varition: costfun_var.m
% %the cost function based on 
% %the constraint equation:fconvwav.m
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%solute the optimal problem%%%%%%%%
% options = optimset('LargeScale','off','MaxFunEvals',18000);
%  a = linspace(0,1,N); %分割   TASE14的prepressing
% %[low,FVAL,EXITFLAG,OUTPUT]=fmincon(@(x)costfun_var(x,p),a,[],[],[],[],[],[],@(x)fconwav(x,N),options);
% 
% %[high,FVAL,EXITFLAG,OUTPUT]=fmincon(@(x)costfun_var(x,p),a,[],[],[],[],[],[],@(x)fconwav(x,N),options);
% 
% % [high,FVAL,EXITFLAG,OUTPUT]=fmincon(@(x)costfun_cor(x,p),a,[],[],[],[],[],[],@(x)fconwav(x,N),options);
% [high,FVAL,EXITFLAG,OUTPUT]=fmincon(@(x)destination(x,p),a,[],[],[],[],[],[],@(x)fconwav(x,N),options);
% figure(2);
% plot(high);  %low pass filter h      %%得到高波
% %%%%%%%%%apply to the image%%%%%%%%%%%
% %I_h=conv2(low,low,I,'same');
% for j=1:N
%   low(j)=(-1)^(j+1)*high(N-j+1);
% end    %低滤波系数
% 
% for k=1:length(T)
% %  I_h=conv2(high,high,I,'same');  %卷积 
% % I_h=double(I_h);
% %  I_adjust0=myimadjust(I_h);   %变成到整数0-255 每个都乘以255/（max-min）
% %  figure(3);imshow(I_adjust0,[]);title(['对角细节版本 T' num2str(T(k))]);
% %  result0=treshold(I_adjust0,T(k));  %大于100的变成了255小雨100的变成0 不是通过直方图获得的
% % figure(4),
% % imshow(result0,[]);title(['对角版本二值化image T=' num2str(T(k))]);
% 
% I_l=conv2(low,low,I,'same');%% 平滑
%  I_adjust1=myimadjust(I_l);
% figure(5), imshow(I_adjust1,[]); title(['smooth T=' num2str(T(k))]);
%  result=treshold(I_adjust1,T(k));   %得到效果最好！羽毛210 
%  figure(6);imshow(result); title('erzhihua_smooth');
%  
% dot_id = strfind(img , '.') ;
% gang_id = strfind(img , '\') ;
% image_name = img(gang_id(end)+1 : dot_id(end) - 1) ;
% write_name = ['..\..\all_results\' image_name '_wavlate_' num2str(T(k)) '.png'];
% imwrite( mat2gray(result) , write_name);
% ori_name = ['..\..\all_results\' image_name '.png'];
% imwrite( mat2gray(J) , ori_name);
% 
% %  I_lh=conv2(low,high,I,'same');
% %   I_adjust2=myimadjust(I_lh);
% %  figure(7);imshow(I_lh,[]);title(['水平细节T=' num2str(T(k))]);
% %  result=treshold(I_adjust2,T(k));  %K是210
% %  figure(8);imshow(result);title('水平二值化细节');
% %  
% %   I_hl=conv2(high,low,I,'same');
% %   I_adjust3=myimadjust(I_hl);
% %  figure(9);imshow(I_lh,[]);title(['垂直细节 T=' num2str(T(k))]);
% %  result=treshold(I_adjust3,T(k));
% %  figure(10);imshow(result);title('垂直二值化细节');
%  pause
%  close all
% end


%% 自动调阈值
function  h=mydwt2(img)   %T为对平滑图像二值化的阈值

J=imread(img);
%  I=imread('15862.jpg');%羽毛
%I=imread('defect2_2.jpg'); 带有图案的效果不好了
%I=imread('pingwen.jpg');
[~ , ~ , chs] = size(J) ;
 if chs > 1
     I = rgb2gray(J) ;
 else
     I = J;
 end
 I = double(I) ;
% I=double(rgb2gray(I));
I=imresize(I,[256,256]);  %放大了I 或调整为256*256
figure(1),title('original image');
imshow(uint8(I),[]); %含某类疵点的图像%
%%%%%length of filter%%%%%%%%%%
N=8;             %截取无瑕疵的图像大小
N1=8;
%%%%%%%choose a section of the texture%%%%%%%%%% N*N
h = get(0,'CurrentFigure');
rect = getrect(h);
xmin = floor(rect(1));%列最小
ymin = floor(rect(2));%行最小
width = floor(rect(3));%宽度
height = floor(rect(4));%高度
section = I(ymin:ymin+height,xmin:xmin+width);
p=fabric_imgcut(section,N,N);
%%%%%%%%%%%define the cost function%%%%%%%%%%%%%%
%the cost function based on the varition: costfun_var.m
%the cost function based on 
%the constraint equation:fconvwav.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%solute the optimal problem%%%%%%%%
options = optimset('LargeScale','off','MaxFunEvals',18000);
 a = linspace(0,1,N); %分割   TASE14的prepressing
%[low,FVAL,EXITFLAG,OUTPUT]=fmincon(@(x)costfun_var(x,p),a,[],[],[],[],[],[],@(x)fconwav(x,N),options);

%[high,FVAL,EXITFLAG,OUTPUT]=fmincon(@(x)costfun_var(x,p),a,[],[],[],[],[],[],@(x)fconwav(x,N),options);

% [high,FVAL,EXITFLAG,OUTPUT]=fmincon(@(x)costfun_cor(x,p),a,[],[],[],[],[],[],@(x)fconwav(x,N),options);
[high,FVAL,EXITFLAG,OUTPUT]=fmincon(@(x)destination(x,p),a,[],[],[],[],[],[],@(x)fconwav(x,N),options);
% I_h=conv2(high,high,I,'same');  %垂直
% I_h=double(I_h);
%  I_adjust0=myimadjust(I_h);   %变成到整数0-255 每个都乘以255/（max-min）
%  figure(3);imshow(I_adjust0,[]);title('duijiao');
% T=graythresh(I_adjust0);
%  result0=treshold(I_adjust0/255,T);  %大于100的变成了255小雨100的变成0 不是通过直方图获得的
% figure(4),
% imshow(result0,[]);title('duijiao_erzhihua');

for j=1:N
  low(j)=(-1)^(j+1)*high(N-j+1);
end    %低滤波系数
I_l=conv2(low,low,I,'same');%%  平滑
I_adjust1=myimadjust(I_l);
T=graythresh(I_adjust1);
result=treshold(I_adjust1/255,T);  
dot_id = strfind(img , '.') ;
gang_id = strfind(img , '\') ;
image_name = img(gang_id(end)+1 : dot_id(end) - 1) ;
write_name = ['..\all_results\' image_name '_wavlate.png'];
imwrite( mat2gray(result) , write_name);  %此处是将二值化的图像即detection result进行存储，论文中采取的是手动与之，当比较irregularity map时 应该存储I_adjust1
%  I_lh=conv2(low,high,I,'same');  %水平
%   I_adjust2=myimadjust(I_lh);
%  figure(7);imshow(I_lh,[]);title('shuiping');
%  T=graythresh(I_adjust2);
%  result=im2bw(I_adjust2/255,T);
%  figure(8);imshow(result);title('erzhi_shuiping');
%  
%   I_hl=conv2(high,low,I,'same');  %对角
%   I_adjust3=myimadjust(I_hl);
%  figure(9);imshow(I_lh,[]);title('cuizhi');
%   T=graythresh(I_adjust3);
%  result=im2bw(I_adjust3/255,T);
%  figure(10);imshow(result);title('erzhi_cuizhi');
 
end
