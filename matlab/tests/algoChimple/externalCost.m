function cost = externalCost(result)
    a = getChimpValue('a');
    b = getChimpValue('b');
    c = getChimpValue('c');
    d = getChimpValue('d');
    
    assertTrue(c==a+b+1);
    assertTrue(result==c);
    
    cost = log(d);
end
