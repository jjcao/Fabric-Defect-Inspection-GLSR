function [patch_textons ] = construct_patch_textons_means( featvec1 , patch_id )

if size(patch_id , 1) > 1
    patch_number = max(max(patch_id));
else
    patch_number = length(patch_id);
end


patch_textons = zeros( size(featvec1 , 1) , patch_number ) ;

if size(patch_id , 1) > 1
    for i = 1 : patch_number
        ind = find(patch_id == i) ;
        patch_textons( : , i ) = mean(featvec1(: , ind) , 2);
    end
else
    for i = 1 : patch_number
        ind = patch_id {i} ;
        patch_textons( : , i ) = mean(featvec1(: , ind) , 2);
    end
end
