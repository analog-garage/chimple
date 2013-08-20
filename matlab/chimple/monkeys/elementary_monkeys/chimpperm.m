function result = chimpperm(name,n)
      
    if nargin<2
        error('needs a number of inputs');
    end
    
    handler = getMonkeyHandler();
    result = handler.chimpPerm(name,n);
    result = reshape(result,1,numel(result));
end
