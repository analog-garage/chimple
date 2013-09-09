function testConst()

    %Create a program that does a flip to determine how to set a const
    %verify that the resulting value of the const and hte flip are the same
    %at each run
    burnin = 50;
    numsamples = 50;
    spacing = 1;
    results = chimplify(@constprogram,burnin,numsamples,spacing);
    setChimpleSeed(0);
    for i = 1:length(results)
       result = results{i};
       a = result{1};
       b = result{2};
       assertEqual(a,b);
    end
    
end