function result = chimprandn(name,mu,sigma,sigma_regen)
      
    if nargin<2
        mu=0;
    end
    if nargin<3
        sigma=1;
    end
    if nargin<4
        sigma_regen=sigma/10;
    end

    handler = getMonkeyHandler();
    result = handler.chimpRandn(name,mu,sigma,sigma_regen);

end
