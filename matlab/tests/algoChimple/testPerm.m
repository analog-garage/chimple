function testPerm

    setChmplSeed(0);

    N = 3;
    M = 1000;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test gen
    counts = containers.Map();
    for i = 1:M
        p = chimpperm('foo',N);
        key = char(p+'a');
        if counts.isKey(key)
            counts(key) = counts(key)+1;
        else
            counts(key) = 1;
        end
    end

    assertEqual(factorial(N),length(counts));
    countVector = cell2mat(counts.values);
    countVector = countVector/sum(countVector);
    diff = norm(countVector - ones(1,length(countVector))/length(countVector));
    assertTrue(diff<.05);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test likelihood
    handler = getMonkeyHandler();
    p = handler.getPerm();
    
    likelihood = p.calculateLikelihood(int32(1:N),int32(N));
    assertEqual(likelihood,log(factorial(N)));


    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test kernel
    N = 5;
    M = 4000;
    counts = zeros(N);
    for i = 1:M
        pair = p.regenerate(int32(1:N),int32(N));
        tmp = reshape(pair.getResult(),1,N);
        hastings = pair.getHastings();
        assertEqual(hastings,0);
        tmp = find(tmp ~= 1:N);
        assertEqual(length(tmp),2);
        counts(tmp(1),tmp(2)) = counts(tmp(1),tmp(2))+1;
    end

    numNonZero = N*(N-1)/2;
    counts = counts / sum(sum(counts))*numNonZero;

    for i = 1:(N-1)
        for j = i+1:N
            assertTrue(abs(counts(i,j)-1)<.2);
        end
    end
end

