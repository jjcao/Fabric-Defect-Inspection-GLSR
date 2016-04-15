function guiding = recover_guiding(dis , patch_id )

patch_number = length(dis);

guiding = zeros( size( patch_id )) ;
for i = 1 : patch_number
    guiding(patch_id == i) = dis(i);
end