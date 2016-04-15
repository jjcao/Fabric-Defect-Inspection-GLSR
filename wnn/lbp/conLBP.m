bark=load('bark.mat');
[a,b]=constructLBP(bark.img,3,3,8,'ri');  %112副图的lbp值 与直方图
%imshow(a(:,:,1),[]);




