function [out]=poissonrng(m)

U=log(1/rand);
out=0;
while U<m
    out=out+1;
    U=U+log(1/rand);
end
