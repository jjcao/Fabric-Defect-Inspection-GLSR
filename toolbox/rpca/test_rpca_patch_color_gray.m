setup

image_name = '..\data\fabric\blemish image\0005.bmp';
I = imread(image_name);
[m , n , chs] = size(I) ;
 if chs > 1
     J = rgb2gray(I) ;
 else
     J = I;
 end
J = double(J);
figure
imshow(J , [])

[X , patch_id] = patch2colorvector_gray(J , 10 , 10);
[L , S] = inexact_alm_rpca(X , 0.1);
%% show
figure;
imshow(L ,[]);
figure;
imshow(abs(S) , []);
%% recover
% [recover_J , saliency_map] = recover_texture_saliency(L , S , patch_id);
[ saliency_map] = recover_saliency(S , patch_id);

figure;
imshow(abs(saliency_map) , []);

%% Gaussian filter
saliency_map = imfilter(saliency_map,fspecial('gaussian',[25,25],4));
%saliency_map = mat2gray(imfilter(saliency_map,fspecial('gaussian',[10,10],2)));

%% 二值化处理
mean_salience = mean(mean(saliency_map));
bina_salience = saliency_map > 2.2 * mean_salience;
figure
imshow( bina_salience , []);
