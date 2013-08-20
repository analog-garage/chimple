function r = dirichletrng(a)
n=length(a);
r=zeros(size(a));
for i=1:n
    r(i)=gammarng(a(i),1,1);
end
r=r/sum(r);
