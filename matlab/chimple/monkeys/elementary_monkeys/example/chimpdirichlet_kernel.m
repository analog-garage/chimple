function [value,hastings]= chimpdirichlet_kernel(oldvalue,alphas)
    ii=0;
    jj=0;
    while ii==jj
        ii=randi(length(oldvalue));
        jj=randi(length(oldvalue));
    end
    
    value = oldvalue;

    a = value(ii);
    b = value(jj);
    total = a+b;
    
    ap = rand()*total;
    bp = total-ap;
    
    value(ii) = ap;
    value(jj) = bp;    
    hastings=0;
end
