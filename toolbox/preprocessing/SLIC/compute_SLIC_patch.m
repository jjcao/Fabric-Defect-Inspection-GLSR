function patch_id = compute_SLIC_patch(imName , compactness , spnumber)

DEBUG = 1;

sep_id = strfind(imName , '.') ;
imPath = imName(1: sep_id(end)) ;
imType = imName(sep_id(end) +1 : end);
if ~strcmpi(imType , 'bmp')
    I = imread(imName) ;
    write_name = [imPath 'bmp'] ;
    imwrite(I , write_name);
    J = imread(write_name) ;
    imName = write_name ;
else
    J =  imread(imName) ;
end

[r , c , chs] = size(J);

patch_id = getSlicLabelMap(imName, compactness, spnumber, r, c);

if DEBUG
    figure('name' , 'patch_id')
    imshow(patch_id , [])
end
