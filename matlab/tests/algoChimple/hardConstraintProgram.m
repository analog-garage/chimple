function output = hardConstraintProgram(numExpected)
    
    count = 0;  
    for i = 1:10
        count = count + chimpflip(sprintf('x%d',i));
    end
    
    if count == numExpected
        addChimpCost(0);
    else 
        addChimpCost(Inf);
    end
    
    output = count;
end

