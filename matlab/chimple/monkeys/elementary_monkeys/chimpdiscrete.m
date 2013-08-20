function result = chimpdiscrete(name,probabilities,sampled_set)
      
    if nargin < 3
        sampled_set = 1:length(probabilities);
    end
    
    if length(probabilities)~=length(sampled_set)
        error('The sampled set and probability vector must have identical length');
    end
    
    if isnumeric(sampled_set)
        sampled_set=num2cell(sampled_set);
    end
    
    if nargin <2
        error('please provide probabilities');
    end
    
        
    %params=cell(3,1);
    %params{1}=probabilities;
    %params{2}=sampled_set;
    handler = getMonkeyHandler();
    result = handler.chimpDiscrete(name,probabilities,sampled_set);

end
