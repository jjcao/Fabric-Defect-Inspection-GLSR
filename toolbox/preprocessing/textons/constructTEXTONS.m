function patch_textons = constructTEXTONS(J , patch_id)

featvec1 = MR8fast( J );

patch_textons = construct_patch_textons_means( featvec1 , patch_id );