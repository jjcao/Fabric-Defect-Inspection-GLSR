setup

% image_name = '..\data\fabric\blemish image(png)\start_1.png';
image_name = '..\data\fabric_jz_test\defect24j.png' ;
I = imread(image_name);
[m , n , chs] = size(I) ;
if chs > 1
    J = rgb2gray(I) ;
else
    J = I;
end
%  J = histeq(J , 2);
% h3=fspecial('gaussian',[3 , 3],0.5);%高斯低通滤波
% J=filter2(h3,J);
figure
imshow(J , [])
J=imresize(J, 140/size(J,2));
J = double(J);
figure
imshow(J , [])
imwrite(J , 'temp_image.bmp');
% m = 15 ; n = 15 ;
% [X , patch_id] = constructTEXTONS(J , m , n);
% [X , patch_id] = constructLBP(J,m ,n ,8,'u2');

% patch_id = compute_uniformly_patch(J , 12 , 12);
% patch_id = compute_SLIC_patch('temp_image.bmp' , 300 , 130);
patch_id = compute_uniformly_size_patch(J , 10 , 5 ) ; %bar 下采样160 子块16,8 start 下采样160块 子块12 6
X  = constructTEXTONS(J , patch_id);
% [Z , t1, t2, S] = frr(X , 20 , 0.02); Z = t1 * t2;
% L = X * Z;
% S = X - L;

% % construct guiding
% patch_prior1 = patch_blemish_prior_colour( J , 'rand' , patch_id);
% patch_prior2 = patch_blemish_prior_textfeature( J , 'lbp' , 'rand'  , m , n , patch_id) ;
patch_prior3 = patch_blemish_prior_textfeature( J , 'textons' , 'rand' , patch_id) ;
patch_prior = patch_prior3;% .* patch_prior3 ; % .* patch_prior3;
patch_prior = patch_prior - min(patch_prior);
patch_prior = patch_prior / max(patch_prior);
prior = recover_saliency( J , patch_prior , patch_id);
figure('name' , 'prior')
imshow(prior , [])
%%  parameter selection
template_feature = compute_feature_template(X);
%%
residual = inf ;
% for lambda = [0.01 0.05 0.1 0.3 0.5 0.7 1]
%     lambda
for lambda = [ 0.001 ] % start 0.1 （a13 0.01）
    %     patch_n = size(X , 2) ; cvx_prior = diag(exp(-patch_prior));
    %     cvx_begin
    %     variable Z(patch_n , patch_n);
    %     minimize( sum_square(Z) + 0.1*sum_square((X-X*Z)*cvx_prior) );
    %     cvx_end
    %     temp_S = X - X*Z;
    
%          [Z , temp_S] = lrr_FF(X , exp(-patch_prior) , lambda) ;
%     [Z , temp_S] = lrr_FF(X , ones(size(patch_prior)) , 0.01) ;
    %     [Z , temp_S] = lrr_FG(X  , exp(-patch_prior) , 0.01);
%         [Z , temp_S] = lrr(X  , 0.01 * mean(exp(-patch_prior)));
    [tt1 , t1, t2, tt2] = frr_GF(X , 5 , lambda , exp(-patch_prior) ); Z = t1 * t2;
    L = X * Z;
    temp_S = X - L;
    [ saliency_map] = recover_saliency(J , temp_S , patch_id);
    figure;
    imshow(abs(saliency_map) , []);
    
    temp_L = X * Z ;
    dis_v = temp_L - repmat(template_feature , 1 ,size(temp_L,2));
    dis = sum(sum(dis_v .* dis_v));
    if dis < residual
        final_lambda = lambda;
        residual = dis;
        L = temp_L;
        S = temp_S;
    end
end
%%



%%
%  [U , S , V] = svd(X);
%  dim = 4 ;
%  L = U(: , 1 : dim) * S(1 : dim , 1: dim) * (V(: , 1 : dim)');
%  S = X - L;
%% show
% figure;
% imshow(L ,[]);
% figure;
% imshow(abs(S) , []);
%% recover

[ saliency_map] = recover_saliency(J , S , patch_id);

figure;
imshow(abs(saliency_map) );

%% Gaussian filter
% saliency_map = imfilter(saliency_map,fspecial('gaussian',[10,10],2));
saliency_map = mat2gray(imfilter(saliency_map,fspecial('gaussian',[10,10],2)));
figure;
imshow(abs(saliency_map) , []);
%% 二值化处理
% mean_salience = mean(mean(saliency_map));
% number = 1 : 0.5 : 10;
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
% end
% bina_salience = saliency_map > 3 * mean_salience;
% figure
% imshow( bina_salience , []);