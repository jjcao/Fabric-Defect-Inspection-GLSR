function M=featureM(img,r,wm,way)  %得到n*m个patch的直方图，以及每个像素的id
mapping=getmapping(wm,way);
M=lbp_fast(img,r,wm,mapping,'nh')';
            