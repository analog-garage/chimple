function compareMeanAndVariance(results,expectedMean,expectedVariance,tolerance)

    if nargin < 4
        tolerance = .05;
    end

    expectedSigma = sqrt(expectedVariance);

    actualMean = sum(results)/length(results);
    actualSigma = sqrt(sum((results - actualMean).^2)/length(results));
    
    meanTolerance = expectedMean*tolerance;
    sigmaTolerance = expectedSigma*tolerance;
    
    assertTrue(abs(actualMean-expectedMean)<meanTolerance);
    assertTrue(abs(actualSigma-expectedSigma)<sigmaTolerance);

end
