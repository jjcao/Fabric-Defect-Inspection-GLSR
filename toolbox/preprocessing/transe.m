clear; clc ; close all ;

I = imread('defect2.jpg');
J = rgb2gray(I);
[h , w , c] = size(I) ;

delete_id = [];
for i = 1 : h
    if sum(J( i , [1 : 5] )) == 5 * 255
       delete_id = [ delete_id i ];
    end 
end
I(delete_id , : , :) = [] ;

[h , w , c] = size(I) ;

delete_id = [];
for i = 1 : w
    if sum(J( [1 : 5] , i )) == 5 * 255
       delete_id = [ delete_id i ];
    end 
end
I( : ,delete_id , :) = [] ;

imwrite(I,'defect2j.png')