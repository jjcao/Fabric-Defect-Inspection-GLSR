setup

image_name = '..\data\box-patterned-fabric_with_groundtruth\all_defect\Bbox_nn_d3.bmp';
I = imread(image_name);
[m , n , chs] = size(I) ;
 if chs > 1
     J = rgb2gray(I) ;
 else
     J = I;
 end
J = double(J);
figure
imshow(J ,[]);
J=imresize(J, 160/size(J,2));

[ patch_id patch_id_rows patch_id_columns ] = compute_uniformly_size_patch(J , 16 , 0) ; %bar 下采样160 子块16,8 start 下采样160块 子块12 6
X  = constructTEXTONS(J , patch_id);
[L , S] = inexact_alm_rpca(X , 0.05);
%% show
figure;
imshow(L ,[]);
figure;
imshow(abs(S) , []);
%% recover
[ saliency_map] = recover_saliency(J , S , patch_id);

figure;
imshow(abs(saliency_map) , []);

%% Gaussian filter
saliency_map = imfilter(saliency_map,fspecial('gaussian',[25,25],4));
%saliency_map = mat2gray(imfilter(saliency_map,fspecial('gaussian',[10,10],2)));

%% 二值化处理
mean_salience = mean(mean(saliency_map));
bina_salience = saliency_map > 3 * mean_salience;
figure
imshow( bina_salience , []);

