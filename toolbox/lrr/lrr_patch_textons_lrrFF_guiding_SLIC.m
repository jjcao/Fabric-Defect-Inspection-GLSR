function  lrr_patch_textons_lrrFF_guiding_SLIC( image_name , options)

 %dow_sampling , patch_type , patch_size , over_size , lambda
if ~isfield(options , 'dow_sampling' );
    dow_sampling = 0;
else
    dow_sampling = options.dow_sampling;
end
patch_size = options.patch_size ;
over_size = options.over_size ;
% reduce_rank = options.reduce_rank;
normal_prior = options.normal_prior;
% binary_thresholds = options.binary_threshold ;
% mul = options.mul ;

dot_id = strfind(image_name , '.') ; sprit_id = strfind(image_name , '\') ;
name = image_name(sprit_id(end) + 1 : dot_id(end) - 1);
write_patch = '..\all_results\';

I = imread(image_name); 
if isfield(options , 'dow_sampling' );
    J=imresize(I, dow_sampling/size(I,2));
    write_name = [write_patch name 'down_sampling' num2str(dow_sampling) '.png'];
    imwrite( mat2gray(J) , write_name);
else
    J = I ;
    write_name = [write_patch name 'down_sampling' num2str(dow_sampling) '.png'];
    imwrite( mat2gray(I) , write_name);
end
imwrite (J , 'temp_image.bmp');
[m , n , chs] = size(I) ;
 if chs > 1
     J = rgb2gray(J) ;
 else
     J = J;
 end
J = double(J);
% m = 15 ; n = 15 ;
% [X , patch_id] = constructTEXTONS(J , m , n);
% [X , patch_id] = constructLBP(J,m ,n ,8,'u2');

% patch_id = compute_uniformly_patch(J , 12 , 12);
patch_id_image = compute_SLIC_patch('temp_image.bmp' , over_size , patch_size );
patch_id =  transform_patch_id(patch_id_image) ;
% [ patch_id patch_id_rows patch_id_columns ] = compute_uniformly_size_patch(J , patch_size , over_size) ; %bar 下采样160 子块16,8 start 下采样160块 子块12 6
X  = constructTEXTONS(J , patch_id);
% X1 = constructLBP_fast_com(J , patch_id_rows , patch_id_columns) ;
% X2 =  constructTEXTONS(J , patch_id);
% X = [X1 ; X2] ;
% [Z , t1, t2, S] = frr(X , 20 , 0.02); Z = t1 * t2;
% L = X * Z;
% S = X - L;

% % construct guiding
% patch_prior1 = patch_blemish_prior_colour( J , 'rand' , patch_id);
% patch_prior2 = patch_blemish_prior_lbp( J , 'rand' , patch_id_rows , patch_id_columns) ;
patch_prior3 = patch_blemish_prior_textons( J , 'rand' , patch_id) ;
% patch_prior = patch_prior3;% .* patch_prior3 ; % .* patch_prior3;
 if normal_prior
%     patch_prior2 = patch_prior2 - min(patch_prior2);
%     patch_prior2 = patch_prior2 ./ max(0.5 * patch_prior2);
    patch_prior3 = patch_prior3 - min(patch_prior3);
    patch_prior3 = patch_prior3 ./ max(patch_prior3);
end
% tp = patch_prior2; tp = tp- min(tp); tp = tp ./ (2*mean(tp));
% prior = recover_saliency( J , -patch_prior2 , patch_id);
% write_name = [write_patch name 'normalprior_lbp' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '_prior' '.png'];
% imwrite( mat2gray( prior ) , write_name);
% tp =  patch_prior3; tp = tp- min(tp); tp = tp ./ (2*mean(tp));
% min_textons = min(patch_prior3)
% max_textons = max(patch_prior3)
% tp = patch_prior3;
% if mul ~= 0
%     tp = tp - min(tp);
%     tp = tp ./  (mul * mean(tp));
% end
% prior = recover_saliency( J , patch_prior3 , patch_id);
% write_name = [write_patch name 'normalprior_textons' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '_prior' '_min' num2str(min_textons) '_max' num2str(max_textons) '.png'];
% imwrite( mat2gray( prior ) , write_name);
tp = patch_prior3; % tp = tp- min(tp); tp = tp ./ (2*mean(tp));
prior = recover_saliency( J , tp , patch_id);
write_name = [write_patch name 'normalprior_textons&lbp' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '_prior' '.png'];
% imwrite( mat2gray( prior ) , write_name);
% figure('name' , 'prior')
% imshow(prior , [])
% write_name = [write_patch name 'normalprior' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '_prior' '.png'];
% imwrite( mat2gray( prior ) , write_name);
%%  parameter selection
template_feature = compute_feature_template(X);
%% 
residual = inf ;

% min_lbp = min(patch_prior2)
% max_lbp = max(patch_prior2)
% tp = patch_prior2 .* patch_prior3;
% max(tp)
% if max(tp) < 0.5
%     tp = tp- min(tp);
% %     tp = tp ./  (mean(tp));
% elseif max(tp) > 2
%     tp = sqrt(tp) ;
%    tp = tp- min(tp);
%     tp = tp ./  max(tp);
% else
%     tp = tp ;
% end
% prior = recover_saliency( J , tp , patch_id);
% write_name = [write_patch name 'normalprior_textons&lbp' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '_prior' '.png'];
% imwrite( mat2gray( prior ) , write_name);
% min_finpri = min(tp)
% max_fin_tp = max(tp)
% tp = tp- min(tp);
% max(tp)
% tp = tp ./  max(2 * tp);
% prior = recover_saliency( J , tp , patch_id);
% write_name = [write_patch name 'normalprior_textons&lbp_post_' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '_prior' '.png'];
% imwrite( mat2gray( prior ) , write_name);
all_lambda = options.lambda;
for lambda = all_lambda % start 0.1 （a13 0.01）
    %     patch_n = size(X , 2) ; cvx_prior = diag(exp(-patch_prior));
    %     cvx_begin
    %     variable Z(patch_n , patch_n);
    %     minimize( sum_square(Z) + 0.1*sum_square((X-X*Z)*cvx_prior) );
    %     cvx_end
    %     temp_S = X - X*Z;
    %          X = X ./ repmat( sqrt(sum( X.^2)) , size(X , 1) , 1) ;

%     D_gauss = fn_dist_l2_sqrt(X', X') ;
%     scale = mean(mean(D_gauss));
%     A_gauss = exp(-D_gauss/(scale));
    [Z , temp_S] = lrr_FF( X , exp(-tp) , lambda) ;
   
%        [Z , temp_S] = lrr_FG( A_gauss  , exp(-tp) , lambda);
%         [Z , temp_S] = lrr(X  , lambda);
%     [tt1 , t1, t2, tt2] = frr_GF(X , reduce_rank , lambda , exp(-patch_prior) ); Z = t1 * t2;
%     L = X * Z;
%     temp_S = X - L;
    [ saliency_map] = recover_saliency(J , temp_S , patch_id);
    write_name = [write_patch name 'our_lam' num2str(lambda * 10000) '_normalprior' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '.png'];
%     imwrite(mat2gray(saliency_map) , write_name);

    %% Gaussian filter
%     saliency_map = imfilter(saliency_map,fspecial('gaussian',[10,10],2));
    saliency_map = mat2gray(imfilter(saliency_map,fspecial('gaussian',[10,10],2)));
    write_name = [write_patch name 'ourgauss&norm_lam' num2str(lambda * 10000) '_normalprior' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '.png'];
    imwrite( saliency_map , write_name);
    
%     level = graythresh( saliency_map ) ;
%     saliency_map_bina = im2bw(saliency_map , level);
%     write_name = [write_patch name 'our_bina_lam' num2str(lambda * 10000) '_normalprior' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '.png'];
%     imwrite( saliency_map_bina , write_name);
    %% optimal parameter
%     temp_L = X * Z ;
%     dis_v = temp_L - repmat(template_feature , 1 ,size(temp_L,2));
%     dis = sum(sum(dis_v .* dis_v));
%     if dis < residual
%         final_lambda = lambda;
%         residual = dis;
%         L = temp_L;
%         S = temp_S;
%     end
end
%



% %%
% %  [U , S , V] = svd(X);
% %  dim = 4 ;
% %  L = U(: , 1 : dim) * S(1 : dim , 1: dim) * (V(: , 1 : dim)');
% %  S = X - L;
% %% show
% % figure;
% % imshow(L ,[]);
% % figure;
% % imshow(abs(S) , []);
% %% recover
% 
% [ saliency_map] = recover_saliency(J , S , patch_id);
% 
% figure;
% imshow(abs(saliency_map) );
% 
% %% Gaussian filter
% % saliency_map = imfilter(saliency_map,fspecial('gaussian',[10,10],2));
% saliency_map = mat2gray(imfilter(saliency_map,fspecial('gaussian',[10,10],2)));
% figure;
% imshow(abs(saliency_map) , []);
% %% 二值化处理
% mean_salience = mean(mean(saliency_map));
% number = 1.5 : 0.5 : 10;
% number_salience = zeros(1 , length(number));
% id = 0;
% for i = number
%     id = id + 1;
%     temp_bina_salience = saliency_map > i * mean_salience;
%     number_salience(id) = sum(sum(temp_bina_salience));
% %     if id > 4
% %         variation1 = (number_salience(id-1) - number_salience(id)) / (number_salience(id-2) - number_salience(id - 1));
% %         variation2 = (number_salience(id-2) - number_salience(id-1)) / (number_salience(id-3) - number_salience(id - 2));
% %     else
% %         variation1 = 0;
% %         variation2 = 1;
% %     end 
% %     if variation1 > 0.9 && variation2 < 0.3
% %         thre = i - 1;
% %         break
% %     end
% if id > 1
%     variation(id) = (number_salience(id-1) - number_salience(id)) ;
% else
%     variation(id) = 0 ;
% end
% end
% bar(number_salience,'DisplayName','number_salience');figure(gcf)
% write_name = [write_patch name 'ourgauss&norm_lam' num2str(lambda * 10000) '_normalprior' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '_number' '.png'];
% print(gcf,'-dpng','-r300', write_name );
% bar( variation ,'DisplayName','variation');figure(gcf)
% write_name = [write_patch name 'ourgauss&norm_lam' num2str(lambda * 10000) '_normalprior' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '_variation' '.png'];
% print(gcf,'-dpng','-r300', write_name );
% mean_salience = mean(mean(saliency_map));
% for thre = binary_thresholds
%     bina_salience = saliency_map > thre * mean_salience;
%     write_name = [write_patch name 'ourgauss&norm_lam' num2str(lambda * 10000) '_normalprior' num2str(normal_prior) '_dow' num2str(dow_sampling) '_patch' num2str(patch_size) '_' num2str(over_size) '_binary' num2str(thre * 10000) '.png'];
%     imwrite(  bina_salience , write_name);
% end






