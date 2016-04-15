function patch_id =  transform_patch_id(patch_id_image)

patch_number = max(max(patch_id_image)) ;

patch_id = cell(1 , patch_id_image);
for i = 1 : patch_number
    patch_id{i} = find(patch_id_image == i) ;
end