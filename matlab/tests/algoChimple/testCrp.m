function testCrp()     

    %simply make sure we don't crash
    burnin = 100;
    samples = 10;
    spacing =10;
    results = chimplify(@crpprogram,burnin,samples,spacing);
end



