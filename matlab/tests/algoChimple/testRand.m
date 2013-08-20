function testRand()

    N = 1000;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %gen
    results = zeros(N,1);
    for i = 1:N
        results(i) = chimprand('foo');
    end

    expectedMean = .5;
    
    compareMeanAndVariance(results,expectedMean,1/12);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %regen
    handler = getMonkeyHandler();
    r = handler.getRand();

    results = zeros(N,1);
    for i = 1:N
         pair = r.regenerate(rand(),{});
         results(i) = pair.getResult();
         assertEqual(pair.getHastings(),0);
    end

    compareMeanAndVariance(results,expectedMean,1/12);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %likelihood
    assertEqual(0,r.calculateLikelihood(rand(),{}));

end
