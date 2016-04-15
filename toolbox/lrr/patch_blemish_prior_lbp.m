function patch_prior = patch_blemish_prior_lbp( J , type , patch_id_rows , patch_id_columns)


[X_guiding] = constructLBP_fast_com(J, patch_id_rows , patch_id_columns);

switch type
    case 'mean'
        average_textons = mean(X_guiding , 2);
    case 'rand'
        temp_feature = zeros(size(X_guiding , 1) , 5);
        for  i = 1 : 5
            temp_id = randi(size(X_guiding , 2) , fix(0.05 * size(X_guiding , 2)));
            temp_feature(: , i) = mean(X_guiding(: , temp_id ) , 2);
        end
        
        mean_feature = mean(temp_feature , 2);
        dis_v = temp_feature - repmat(mean_feature , 1 , size(temp_feature , 2));
        dis = sum(dis_v .* dis_v) ;
        [~ , id] = min(dis);
        
        average_textons = temp_feature(: , id) ;
end

% average_textons =   [0.086313858768949
%    0.090197982413551
%    0.027674380967794
%    0.049037061013109
%    0.042995090899283
%    0.046771322220424
%    0.023736311161461
%    0.103468738199277
%    0.097264929600259
%    0.432540324755894
%    0.037586877953850
%    0.036919655268279
%    0.005170975813178
%    0.002780094523214
%    0.006338615512927
%    0.014234083958855
%    0.011620795107034
%    0.021573533500139
%    0.020961912705032
%    0.018237420072282
%    0.009285515707534
%    0.009452321378927
%    0.004948568251321
%    0.002112871837642
%    0.003558520989714
%    0.043869891576314
%    0.046761189880456
%    0.704587155963303];
dis_v = X_guiding - repmat(average_textons , 1 , size(X_guiding , 2)) ;
patch_prior = sum(dis_v.^2) ;
% guiding = recover_guiding(patch_prior , patch_id ) ;
% figure
% imshow(guiding , []);