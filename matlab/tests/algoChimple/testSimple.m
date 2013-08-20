function testSimple()

    burnin = 10;
    samples = 20;
    spacing = 30;
    arg = rand();
    global count___;
    count___ = 0;

    results = chimplify(@simpleProgram,burnin,samples,spacing,{arg});

    %First test that the counts are correct
    assertTrue(length(results)==samples);
    for i = 1:length(results)
        tmp = results{i};

        %verify correct spacing and burnin
        assertTrue(tmp{1}==(i-1)*(spacing+1)+burnin);

        %verify arguments are passed
        assertTrue(tmp{2}==arg);
    end

end

%Test that likelhood is valid?

%verify hard constraint

%verify soft constraint gets us in right neighborhood.

%test all distributions

%test all other math calculations


