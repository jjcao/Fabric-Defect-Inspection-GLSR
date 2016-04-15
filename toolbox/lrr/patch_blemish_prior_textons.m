function patch_prior = patch_blemish_prior_textons( J , type , patch_id)


[X_guiding] = constructTEXTONS(J, patch_id);

switch type
    case 'mean'
        average_textons = mean(X_guiding , 2);
    case 'rand'
        temp_feature = zeros(size(X_guiding , 1) , 7);
        for  i = 1 : 7
            temp_id = randi(size(X_guiding , 2) , fix(0.07 * size(X_guiding , 2)));
            temp_feature(: , i) = mean(X_guiding(: , temp_id ) , 2);
        end
        
        mean_feature = mean(temp_feature , 2);
        dis_v = temp_feature - repmat(mean_feature , 1 , size(temp_feature , 2));
        dis = sum(dis_v .* dis_v) ;
        [~ , id] = min(dis);
        
        average_textons = temp_feature(: , id) ;
end

dis_v = X_guiding - repmat(average_textons , 1 , size(X_guiding , 2)) ;
patch_prior = sum(dis_v.^2) ;
% guiding = recover_guiding(patch_prior , patch_id ) ;
% figure
% imshow(guiding , []);