function patch_id = compute_uniformly_size_patch(J , patch_size , overlap_size)

DEBUG = 1 ;
[h , w] = size(J) ;

non_overlap_size = patch_size - overlap_size;
if mod((h - overlap_size) , non_overlap_size) == 0
    rows = floor ((h - overlap_size) / non_overlap_size);
else
    rows = floor ( ((h - overlap_size) / non_overlap_size) + 1 );
end
if mod((w - overlap_size) , non_overlap_size) == 0
    columns = floor ( (w - overlap_size) / non_overlap_size );
else
    columns = floor ( ((w - overlap_size) / non_overlap_size) + 1 );
end
patch_number = rows * columns ;

patch_id = cell( 1 , patch_number ); t_id = 0 ;
temp_id = zeros(h , w);
for i = 1 : rows 
    for j = 1 : columns 
        t_id = t_id + 1;
        if i == rows
            rows_id = h - patch_size + 1 : h;
        else
            rows_id = (i-1) * non_overlap_size + 1 : i *  non_overlap_size + overlap_size;
        end
        if j == columns
            columns_id = w - patch_size + 1 : w;
        else
            columns_id = (j-1) * non_overlap_size + 1 : j *  non_overlap_size + overlap_size;
        end
        temp_id( rows_id , columns_id) = t_id ;
        patch_id{t_id} = find(temp_id == t_id);
    end
end

if DEBUG
    figure('name' , 'temp_id')
    imshow(temp_id , [])
end
