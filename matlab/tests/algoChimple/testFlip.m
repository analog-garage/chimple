function testFlip()

    setChmplSeed(0);
    N = 1000;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test gen
    p = rand();
    successes = 0;
    for i = 1:N
        tmp = chimpflip('foo',p);
        successes = successes+tmp;
    end
    assertTrue(abs(p-successes/N) < p*.05);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test regen
    handler = getMonkeyHandler();
    flip = handler.getFlip();
    for i = 1:N
        value = rand < .5;
        pair = flip.regenerate(int32(value),{p});
        result = pair.getResult();
        hastings = pair.getHastings();
        assertEqual(result,double(~value));
        assertEqual(hastings,0);
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test likelihood
    actual = flip.calculateLikelihood(int32(1),{p});
    expected = -log(p);
    assertEqual(actual,expected);


    actual = flip.calculateLikelihood(int32(0),{p});
    expected = -log(1-p);
    assertEqual(actual,expected);

end
