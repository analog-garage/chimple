function testDemos()
    global CHIMPLE_TEST_DEMOS_RUNNING
    CHIMPLE_TEST_DEMOS_RUNNING = true;
    
    current_pwd = pwd();
    setChimpleSeed(0);
    cd('../../../demo/1_basic/');
    run;
    assertTrue(mean(weights) > 0.7);
    cd(current_pwd);
    
    setChimpleSeed(0);
    cd('../../../demo/2_medical_BN/');
    run
    cd(current_pwd);
    assertTrue(all(sum(totals,2) >= 2));

    CHIMPLE_TEST_DEMOS_RUNNING = false;
end