function [ re_saliency] = recover_saliency( J , saliency , patch_id)

if size(patch_id , 1) > 1
    patch_number = max(max(patch_id));
else
    patch_number = length(patch_id);
end


re_saliency = zeros( size( J )) ;
if size(patch_id , 1) > 1
    if size(saliency,1) ==1
        for i = 1 : patch_number
            re_saliency(patch_id == i) =  re_saliency(patch_id == i) + saliency( : , i) ;
        end
    else
        for i = 1 : patch_number
            re_saliency(patch_id == i) = re_saliency(patch_id == i) + (saliency( : , i)' * saliency( : , i));
        end
    end
else
     if size(saliency,1) ==1
        for i = 1 : patch_number
            ind = patch_id{i} ;
            re_saliency(ind) = re_saliency(ind) + saliency( : , i) ;
        end
    else
        for i = 1 : patch_number
            ind = patch_id{i} ;
            re_saliency(ind) = re_saliency(ind) + (saliency( : , i)' * saliency( : , i));
        end
    end
end