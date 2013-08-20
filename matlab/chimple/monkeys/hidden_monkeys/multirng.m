function [out]=multirng(ps,n)


out=zeros(1,n);
for k=1:n
    ps2=cumsum(ps)/sum(ps);

    U=rand();
    temp=1;
    while U>ps2(temp)
        temp=temp+1;
    end
    out(temp)=out(temp)+1;
end
