clear ; clc ; close all;

I = imread('a1.bmp');
[m , n , chs] = size(I) ;
 if chs > 1
     J = rgb2gray(I) ;
 else
     J = I;
 end
 figure
 imshow( J , []);
 J = histeq(J , 2);
 figure
 imshow( J , []);
 
[a1,b1]=constructLBP(J,10,10,8,'ri');  %112副图的lbp值 与直方图





