function result = constprogram()
    
    c1 = chimpflip('a',0.2);
    chimpconst('c',c1);
    c2 = getChimpValue('c');
    result = {c1,c2};
end