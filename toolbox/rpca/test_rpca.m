setup

image_name = '..\data\IMAGE\5.jpg';
I = imread(image_name);
J = rgb2gray(I);
J = double(J);
[L , S] = inexact_alm_rpca(J , 0.2);
figure;
subplot( 1 , 3 , 1) ; imshow(J , []);
subplot( 1 , 3 , 2) ; imshow(L ,[]);
subplot( 1 , 3 , 3) ; imshow(abs(S) , []);

[U , S , V] = svd(J);
L = U(: , 1 : 2) * S(1 : 2 , 1: 2) * (V(: , 1 : 2)');
imshow(L , []);
S = J - L;
figure;
subplot( 1 , 3 , 1) ; imshow(J , []);
subplot( 1 , 3 , 2) ; imshow(L ,[]);
subplot( 1 , 3 , 3) ; imshow(abs(S) , []);




