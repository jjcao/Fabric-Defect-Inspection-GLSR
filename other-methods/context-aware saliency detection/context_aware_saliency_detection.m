function [MOV] = context_aware_saliency_detection(image_name)

%% load parameters and images
file_names{1} = image_name;
MOV = saliency(file_names);


%% display results
dot_id = strfind(image_name , '.') ; sprit_id = strfind( image_name , '\') ;
name = image_name(sprit_id(end) + 1 : dot_id(end) - 1);
write_patch = '..\all_results\';
write_name = [write_patch name 'context_aware_saliency' '.png'];
imwrite( MOV{1}.SaliencyMap , write_name);
    
    
    