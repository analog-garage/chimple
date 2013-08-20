function testFactorial

    %0-99 will be cached.  100-Inf uses stirling.  We test three values
    %with stirling's approximation
    for i = 0:102
        assertElementsAlmostEqual(log(factorial(i)),com.analog.lyric.math.Functions.logfactorial(i));
    end
    
end
