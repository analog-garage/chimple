function testGamma()

    setChmplSeed(0);
    
    N = 3000;

    alpha = 4;
    beta = 5;
    results1 = zeros(N,1);
    results2 = zeros(N,1);

    r = com.analog.lyric.math.RandomPlus();

    for i = 1:N
        results1(i) = gammarng(alpha,beta,1);
        results2(i) = r.nextGamma(alpha,beta);
    end

    [x1,y1] = hist(results1);
    [x2,y2] = hist(results2);

    x1 = x1/sum(x1);
    x2 = x2/sum(x2);

    diff = x1-x2;

    assertTrue(norm(diff)<.4);
end
