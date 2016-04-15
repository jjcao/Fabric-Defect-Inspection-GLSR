function patch_id = compute_uniformly_patch(J , m , n)

DEBUG = 1 ;

[h , w] = size(J) ;
bool1 = mod(h , m ); bool2 = mod(w , n);
patch_number = m * n;
if bool1 || bool2
    warning(' not just in time ')
end
sub_H = fix(h/m); sub_w = fix(w/n);

patch_id = zeros( size(J) ); t_id = 0 ;
for i = 1 : m 
    for j = 1 : n 
        t_id = t_id + 1;
        patch_id( (i-1) * sub_H + 1 : min(i * sub_H , h) , (j-1) * sub_w + 1 : min( j * sub_w , w) ) = t_id ;
    end
end

if DEBUG
    figure('name' , 'patch_id')
    imshow(patch_id , [])
end
