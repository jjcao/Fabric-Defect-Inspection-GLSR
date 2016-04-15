function template_feature = compute_feature_template(X)

temp_feature = zeros(size(X , 1) , 5);
for  i = 1 : 5
    temp_id = randi(size(X , 2) , fix(0.05 * size(X , 2)));
    temp_feature(: , i) = mean(X(: , temp_id ) , 2);
end

mean_feature = mean(temp_feature , 2);
dis_v = temp_feature - repmat(mean_feature , 1 , size(temp_feature , 2));
dis = sum(dis_v .* dis_v) ;
[~ , id] = min(dis);

template_feature = temp_feature(: , id) ;