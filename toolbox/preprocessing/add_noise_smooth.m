
clear ; clc ; close all ;

path = ['..\data\temp_8_8'] ;

files = dir(path);

write_path = ['..\data\temp_8_8'] ;
for  file_count = 3 : length(files)
    image_name = [path '\' files(file_count).name] ;
    
    I = imread(image_name) ;
    [m , n , chs] = size(I) ;
    
    %% 随机噪声
%     snoise = 0.2 * randn(size(I)) ;
%     J =imadd( I , im2uint8(snoise) ) ;
%     h3 = fspecial('gaussian' , [3 , 3] , 0.5);%高斯低通滤波
%     for i = 1 : chs
%         J(: ,:, i) = filter2(h3 , J(: ,:, i));
%     end
    %% 高斯噪声
    J = imnoise( I ,'gaussian',0,0.02);
    
%     subplot( 1, 2 , 1 ) ; imshow(I , []) ;
%     subplot( 1 , 2, 2) ;  imshow(J , []) ;
    
    dot_id = strfind(image_name , '.') ; sprit_id = strfind(image_name , '\') ;
    name = image_name(sprit_id(end) + 1 : dot_id(end) - 1);
    write_name = [write_path '\' name '_noise.png'];
    imwrite( J , write_name);
end