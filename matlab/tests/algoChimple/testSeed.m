function testSeed

firstNum0s = 0;
firstNum1s = 0;

for i = 1:10

    burnin = 10;
    samples = 100;
    spacing = 0;
    
    setChmplSeed(0);
    
    results = chimplify(@biasprogram,burnin,samples,spacing);

    num1s = sum(cell2mat(results));
    num0s = samples - num1s;

    if i == 1
        firstNum0s = num0s;
        firstNum1s = num1s;
    else
        assertTrue(firstNum0s == num0s);
        assertTrue(firstNum1s ==  num1s);
    end
end
