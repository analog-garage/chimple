function testBias()

global DIMPLE_TEST_VERBOSE;
if (~exist('DIMPLE_TEST_VERBOSE','var') || DIMPLE_TEST_VERBOSE); silent = false; else silent = true; end;

    tic

    burnin = 300;
    samples = 600;
    spacing = 0;
    results = chimplify(@biasprogram,burnin,samples,spacing);

    if (~silent)
        toc
    end

    num1s = sum(cell2mat(results));
    num0s = samples - num1s;

    if (~silent)
        num0s
        num1s
    end

    assertTrue(num0s > 200);
    assertTrue(num1s > 200);

    %results = cell2mat(results);

    %hist(results);
end

