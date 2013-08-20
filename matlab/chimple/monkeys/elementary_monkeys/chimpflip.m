function result = chimpflip(name,weight)
     
    if nargin < 2
        weight = .5;
    end
    
    handler = getMonkeyHandler();
    result = handler.chimpFlip(name,weight);
end
