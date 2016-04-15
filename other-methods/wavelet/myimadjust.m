function B=myimadjust(A)
[m,n]=size(A);
   MIN=min(min(A));
    MAX=max(max(A));
    for i=1:m
        for j=1:n
            A(i,j)=A(i,j)-MIN;
            B(i,j)=A(i,j)*255/(MAX-MIN);
        end
    end
    
        