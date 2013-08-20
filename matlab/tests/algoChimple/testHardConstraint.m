function testHardConstraint()

    tic
    burnin = 100;
    samples = 100;
    spacing = 20;
    numExpected = 4;

    results = chimplify(@hardConstraintProgram,burnin,samples,spacing,{numExpected});

    for i = 1:length(results)
        assertTrue(results{i} == numExpected);
    end
    toc
end
