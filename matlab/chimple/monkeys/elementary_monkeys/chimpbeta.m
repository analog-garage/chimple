function result = chimpbeta(name,alpha,beta,sigma)
      
    
    if (nargin<3)||(alpha<0) || (beta<0)
        error('requires a positive input values alpha and beta')
    end
    
    handler = getMonkeyHandler();
    
    if nargin < 4
        result = handler.chimpBeta(name,alpha,beta);
    else
        result = handler.chimpBeta(name,alpha,beta,sigma);
    end    
    
end
