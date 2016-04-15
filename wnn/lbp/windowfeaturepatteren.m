function [fea_lbp,patch_id,record] = windowfeaturepatteren(img , r,wm, patch_size , overlap_size)
[h , w] = size(img) ;
mapping=getmapping(wm,'riu2');
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
K=0;
patch_number = rows * columns ;
for i = 1 : rows 
    for j = 1 : columns 
       K = K + 1;
        if i == rows
            rows_id = h - patch_size+1 : h;
        else
            rows_id = (i-1) * non_overlap_size + 1 : i *  non_overlap_size + overlap_size;
        end
        if j == columns
            columns_id = w - patch_size+1: w;
        else
            columns_id = (j-1) * non_overlap_size + 1 : j *  non_overlap_size + overlap_size;
        end
        subI=img(rows_id,columns_id);           %µÚi¸öpatch
        Wdist=lbp_fast(subI,r, wm,mapping,'nh')';
           if i==1&j==1
                hist=Wdist;
            else
                hist=[hist,Wdist];
           end 
        patch_id(rows_id,columns_id)=K*ones(length(rows_id),length(columns_id));
        record(K).row=rows_id;
       record(K).column=columns_id;
       record(K).num=K;
    end
end
 fea_lbp(:,:)=hist;

