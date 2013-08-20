function result = externalCostProgram()
    a = chimpflip('a');
    b = chimpflip('b');
    c = chimpconst('c',a+b+1);
    chimpconst('d',10);
    
    result = c;
end
