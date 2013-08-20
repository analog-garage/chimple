function [out]=bernoulli(n,p)
temp=1;
out=0;
while temp<=n
    out=out+(rand()<p);
    temp=temp+1;
end
    
