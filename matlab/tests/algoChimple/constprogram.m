function result = constprogram()
    
    c1 = chimpFlip('a',0.2);
    chimpConst('c',c1);
    c2 = getChimpValue('c');
    result = {c1,c2};
end