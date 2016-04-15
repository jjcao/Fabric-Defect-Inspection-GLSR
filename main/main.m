setup  %加载算法路径
path = '..\data\temp_7_27' ; %数据路径，我们把结果保存在了all_result文件夹，若要更改可以到相应算法出更改。
files = dir(path);
%     for dow_sampling = [ 160 120 140 ]
%     for patch_size = [ 14 12 10 16 18 ] ;
%     for lambda = [0.0001 0.0005 0.001 0.005 0.01]
%     for reduce_rank = [ 5 2 4 7 ]
%     reduce_rank = 5 ;
for  file_count = 3 : length(files)
    image_name = [path '\' files(file_count).name] ;
    if strfind(image_name , 'groundT')
        continue ;
    end
    disp(['process the number of ' num2str(file_count-2) ' image'])
    for dow_sampling = 160
        for patch_size = 16
            for over_size = 8 ;
                options.dow_sampling = dow_sampling ;
                options.patch_size = patch_size ;
                options.over_size = over_size ;
                options.lambda = [0.75] ;
                options.normal_prior = 0;
                lrr_patch_textons_lrrFF_guiding( image_name , options);
            end
        end
    end
%     
%% RRSVD   
        mysvd(image_name);  
%% wavelet %选取的水平方向
        mydwt2(image_name)   %包括手动阈值和自动阈值
%% LBP    
        Wd =  26;
        r1 = 1; r2 = 2;
        wm1 = 8 ;wm2 = 16 ;
        way = 'riu2';
        toversize = 2; oversize = 13;
        thre_mul = [0.8 1.0 1.2 1.4 1.5 1.7 2] ;
        modifymain(image_name,Wd,r1,r2,wm1,wm2,way,toversize,oversize , thre_mul);
end 