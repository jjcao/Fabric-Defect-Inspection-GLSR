function  [X patch_id]= patch2colorvector_gray(J , m , n)

[H , W] = size(J) ;
sub_H = fix(H/m);
sub_W = fix(W/n);

patch_id = zeros(H , W);
X = zeros( sub_H * sub_W , m * n);
temp_patch_id = 1;
for tr = 1 : m
    for tc = 1 : n
        tr_id = ((tr - 1) * sub_H + 1) : tr * sub_H;
        tc_id = ((tc - 1) * sub_W + 1) : tc * sub_W;
        patch_id(tr_id , tc_id) = temp_patch_id;
        X(: , temp_patch_id) = reshape(J(tr_id , tc_id) , sub_H * sub_W  , 1);
        temp_patch_id = temp_patch_id + 1;
    end
end

%imshow(patch_id,[]);
figure
imshow(X , [])