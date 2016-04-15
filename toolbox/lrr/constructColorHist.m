function patch_colorhist = constructColorHist(im , patch_id  ,bins)

patch_number = max(max( patch_id ));

step = (max(max(im)) - min(min(im))) / bins;
x = min(min(im)) - step/2 : step : max(max(im));
p=1;
for i = 1 : patch_number
    pix_id = find(patch_id == i);
    subI=im(pix_id);
    % mapping=getmapping(field,way);
    subHist=hist(subI(: ) , x)';
    if i==1
        temp_hist=subHist;
    else
        temp_hist=[temp_hist,subHist];
    end
end
patch_colorhist = temp_hist;