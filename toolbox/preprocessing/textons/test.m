clc ; clear ; close all ;

 I = imread('defect11j.png');
 [m , n , chs] = size(I) ;
 if chs > 1
     J = rgb2gray(I) ;
 else
     J = I;
 end
 figure
 imshow( J , []);
%  J = histeq(J);
%  figure
%  imshow( J , []);
%  featvec1 = MRS4fast( J );

patch_id = compute_SLIC_patch('defect11j.png' , 10 , 200);
patch_textons  = constructTEXTONS(J , patch_id);
%  bins = 20;
%  [patch_textons patch_id] = construct_patch_textons_hist( J , featvec1 , 10 , 10 , bins );

% [IDX center] = kmeans( featvec1' , 100);
figure
imshow([ patch_textons + 1] , []) 
figure
imshow([ patch_id ] , [])
%  

