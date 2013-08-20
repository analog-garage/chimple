function testDiscrete()

    N = 3;
    M = 1000;
    setChmplSeed(0);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %test gen
    probs = rand(1,N);
    alphabet = cell(N,1);
    for i = 1:N
       alphabet{i} = char('a' + i-1);
    end

    results = zeros(M,1);
    for i = 1:M
        tmp = chimpdiscrete('foo',probs,alphabet);
        results(i) = tmp-'a'+1;
    end


    [a,b]=hist(results,unique(results));

    norma = a/sum(a);
    normprobs = probs / sum(probs);
    %norma
    %normprobs
    diff = norm(norma-normprobs);
    assertTrue(diff<.1);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %test likelihood
    handler = getMonkeyHandler();
    d = handler.getDiscrete();
    HT = java.util.HashMap();
    for i = 1:N
       HT.put(char('a'+i-1),int32(i-1)); 
    end
    results = zeros(1,N);
    for i = 1:N
        results(i) = d.calculateLikelihood(char('a'+i-1),{probs,alphabet,HT});
    end

    assertEqual(probs,results);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %test regen
    probs = rand(1,N);
    alphabet = cell(N,1);
    for i = 1:N
       alphabet{i} = char('a' + i-1);
    end

    results = zeros(M,1);
    for i = 1:M
        pair = d.regenerate([],{probs,alphabet,HT});
        tmp = pair.getResult();
        H = pair.getHastings();
        assertEqual(H,0);
        results(i) = tmp-'a'+1;
    end


    [a,b]=hist(results,unique(results));

    norma = a/sum(a);
    normprobs = probs / sum(probs);
    %norma
    %normprobs
    diff = norm(norma-normprobs);
    assertTrue(diff<.1);
end
