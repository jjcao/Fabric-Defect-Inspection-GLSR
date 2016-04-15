function [patch_textons patch_id] = construct_patch_textons_hist( J , featvec1 , m , n , bins)

[h , w] = size(J) ;
bool1 = mod(h , m ); bool2 = mod(w , n);
patch_number = m * n;
if bool1 || bool2
    warning(' not just in time ')
    if bool1
        rm = m+ 1;
    end
    if bool2
        rn = n + 1;
    end
    patch_number = rm * rn;
end
sub_H = fix(h/m); sub_w = fix(w/n);

[IDX center] = kmeans( featvec1' , bins);
x = 1 : 1 : bins;

patch_id = zeros( size(J) ); t_id = 0 ;
patch_textons = zeros( bins , patch_number ) ;
for i = 1 : m + 1
    for j = 1 : n + 1
        t_id = t_id + 1;
        patch_id( (i-1) * sub_H + 1 : min(i * sub_H , h) , (j-1) * sub_w + 1 : min( j * sub_w , w) ) = t_id ;
        ind = find(patch_id == t_id) ;
        
        patch_textons( : , t_id ) = hist(IDX(ind) , x);
    end
end
