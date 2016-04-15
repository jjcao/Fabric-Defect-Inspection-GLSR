function wavemain()
clear ; clc ; close all ;
path='..\..\data\temp_4_2';
files=dir(path);
%  T=[130 140 150 170 180 200 210 220 230 240]; %ãÐÖµ
for file_count=3:length(files)
      image_name=[path '\' files(file_count).name];
        mydwt2(image_name);
   
end
    
