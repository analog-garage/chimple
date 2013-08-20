function result = chimpdirichlet(name,alphas)
      
    
    if (nargin<2)||(sum(alphas<0)>0)
        error('requires a positive input vector alpha')
    end
    
        

    %params=cell(1,1);
    %params{1}=alphas;
    
    handler = getMonkeyHandler();
    
    result = handler.chimpDirichlet(name,alphas);
    result = reshape(result,1,numel(result));
    
end
