function [re_texture , re_saliency] = recover_texture_saliency(texture , saliency , patch_id)

patch_number = size(texture , 2) ;

re_texture = zeros( size ( patch_id )) ;
re_saliency = zeros( size ( patch_id )) ;
for i = 1 : patch_number
    [temp_row temp_column] = find(patch_id == i) ;
    rows_number = max(temp_row) - min(temp_row) + 1; columns_number = max(temp_column) - min(temp_column) + 1; 
    temp_texture = reshape(texture( : , i) , rows_number , columns_number) ;
    temp_saliency = reshape(saliency( : , i) , rows_number , columns_number) ;
    re_texture(patch_id == i) = temp_texture;
    re_saliency(patch_id == i) = temp_saliency;
end