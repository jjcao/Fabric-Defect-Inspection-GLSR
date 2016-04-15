function patch_prior = patch_blemish_prior_textons_compare( J , type , patch_id)


[X_guiding] = constructTEXTONS(J, patch_id);

switch type
    case 'mean'
        average_textons = mean(X_guiding , 2);
    case 'rand'
        num1_all = [3 : 2 : 15];
        num2_all = [3 : 2 : 15];
        count1 = 0 ; count2 = 0;
        average_textons = zeros(size(X_guiding , 1) , length(num1_all)*length(num2_all));
        for num1 = num1_all
            count1 = count1 + 1;count2 = 0;
            for num2 = num2_all
                count2 = count2 + 1;
                temp_feature = zeros(size(X_guiding , 1) , num1);
                for  i = 1 : num1
                    temp_id = randi(size(X_guiding , 2) , num2);
                    temp_feature(: , i) = mean(X_guiding(: , temp_id ) , 2);
                end
                
                mean_feature = mean(temp_feature , 2);
                dis_v = temp_feature - repmat(mean_feature , 1 , size(temp_feature , 2));
                dis = sum(dis_v .* dis_v) ;
                [~ , id] = min(dis);
                
                average_textons(: , ((count1-1)*length(num1_all)) + count2) = temp_feature(: , id) ;
                clear temp_feature temp_id dis_v dis id
            end
        end
end
nor_v1 = sqrt(repmat(sum(average_textons .* average_textons) , size(average_textons , 2) , 1));
max_l = max(max(nor_v1));
dis_angle = acos(abs((average_textons' * average_textons) ./(nor_v1.*nor_v1')));
minv = min(min(dis_angle));maxv = max(max(dis_angle));
step1 = (maxv - minv) / 45;
x1 = [minv+step1/2 : step1 :maxv];
y1 = reshape(dis_angle , size(dis_angle , 1) * size(dis_angle , 2),1);
figure
hist(y1 , x1);
temp_v = average_textons ./ max_l;
dis_euc = fn_dist_l2(temp_v);
mind = min(min(dis_euc));maxd = max(max(dis_euc));
step2 = (maxv - minv) / 45;
x2 = [mind+step2/2 : step2 :maxd];
y2 = reshape(dis_euc , size(dis_euc , 1) * size(dis_euc , 2),1);
figure
hist(y2 , x2);

dis_v = X_guiding - repmat(average_textons(: , 1) , 1 , size(X_guiding , 2)) ;
patch_prior = sum(dis_v.^2) ;
% guiding = recover_guiding(patch_prior , patch_id ) ;
% figure
% imshow(guiding , []);