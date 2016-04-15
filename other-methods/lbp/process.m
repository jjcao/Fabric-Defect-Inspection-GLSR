function saliency=process(DL,Dpatch_id,T)
 [m,n]=size(DL);
 for i=1:m
     [a,b]=find(Dpatch_id==i);
         if(DL(i)>T)
             for j=1:a
                 for k=1:b
                     Dpatch_id=1;
                 end
             end
         else
             for j=1:a
                 for k=1:b
                     Dpatch_id=0;
                 end
             end
         end
 end
 saliency-Dpathc_id;
             
             
                     
       