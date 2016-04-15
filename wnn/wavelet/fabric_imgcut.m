%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%从img_src上剪切一幅宽为width高为height图像
%function img_cut = fabric_imgcut(img_src, width, height)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function img_cut = fabric_imgcut(img_src, width, height)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[p1,p2] = size(img_src); 
if(width > p1||height > p2)
    disp('!!!!!width or height is overflowed');
else
    %在原图img_src基础上裁剪得到一幅256*256大小的图像img_cut
    img_cut = img_src(floor(p1 / 2 - width / 2+1) : floor(p1 / 2 + width / 2) ,floor(p2 / 2- height / 2+1) : floor(p2 / 2+ height / 2) );
end