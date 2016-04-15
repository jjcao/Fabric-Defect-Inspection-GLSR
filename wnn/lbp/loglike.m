function L=loglike(M,S)
[a,b]=size(S);
L=zeros(b,1);
for i=1:b
    for j=1:a
      L(i)=L(i)+(S(j,i).^2)/M(j);
    end
    L(i)=L(i)-1;
end
