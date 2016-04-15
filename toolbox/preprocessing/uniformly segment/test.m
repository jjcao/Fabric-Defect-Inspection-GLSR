clear ; clc ; close all;

imname = 'defect10j.bmp' ;
I = imread(imname) ;

[h , w , chs] = size(I);
if chs > 1
    J = rgb2gray(I);
else
    J = I ;
end

m = 16 ;
n = 8;
patch_id =  compute_uniformly_size_patch(J , m , n);
