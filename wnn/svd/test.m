clear ; clc ; close all ; 

im_name = '..\..\experiment\data\fabric_jz_test\wnn1.jpg' ;
[period,patternA,svdmodle,svdmap] = mysvd(im_name);
