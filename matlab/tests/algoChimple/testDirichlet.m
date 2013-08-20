function testDirichlet()

    setChmplSeed(0);
    alphas = [2 3 5];
    N = 500;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %gen
    results = zeros(N,length(alphas));
    for i = 1:N
       results(i,:) = chimpdirichlet_example('foo',alphas); 
    end

    results2 = zeros(N,length(alphas));
    for i = 1:N
        results2(i,:) = chimpdirichlet('foo',alphas);
    end

    means = sum(results)/size(results,1);
    diff = norm(means-alphas/sum(alphas));
    assertTrue(diff < .05);

    means2 = sum(results2)/size(results2,1);
    diff = norm(means2-alphas/sum(alphas));
    assertTrue(diff < .05);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %regen
    handler = getMonkeyHandler();
    monkey = handler.getDirichlet();

    values = rand(1,3);
    values = values/sum(values);

    for i = 1:N
        [newval,hastings] = chimpdirichlet_kernel(values,alphas);
        pair = monkey.regenerate(values,{alphas});
        newval2 = pair.getResult();
        newval2 = reshape(newval2,1,numel(newval2));
        hastings2 = pair.getHastings();


        assertEqual(hastings,0);
        assertEqual(hastings2,0);

        assertElementsAlmostEqual(sum(newval),1);
        assertElementsAlmostEqual(sum(newval2),1);
        assertEqual(sum(values~=newval),2);
        assertEqual(sum(values~=newval2),2);
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %likelihood
    %pdf = 1/B(a) * prod(x_i^(a_i-1))
    %B(a) = prod(gamma(a_i)) / gamma(sum(a_i))
    %-log pdf = log(B(a)) - a_0*log(x_0) - a_1*log(x_1);
    %log(B(a)) = log(gamma(a_0))+log(gamma(a_1)) - log(gamma(sum_ai))
    values = rand(1,3);
    logB = sum(gammaln(alphas)) - gammaln(sum(alphas));
    expected = logB - sum((alphas-1).*log(values));
    actual = chimpdirichlet_likelihood(values,alphas);
    assertElementsAlmostEqual(expected,actual);

    actual2 = monkey.calculateLikelihood(values,{alphas});
    assertElementsAlmostEqual(expected,actual2);

end

