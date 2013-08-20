function result = chimpdirichlet_likelihood(value,alphas)
    %-log(P(value|param1,param2,param3))
    
    
    %fast computation without normalization
    %result=-sum((alphas-1).*log(value));
    
    %exact computation, but the constant term should hopefully be useless
    
    result=sum(gammaln(alphas))-gammaln(sum(alphas))-sum((alphas-1).*log(value));
    
end
