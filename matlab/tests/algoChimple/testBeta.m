%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright 2013 Analog Devices Inc.
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%
%       http://www.apache.org/licenses/LICENSE-2.0
%
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function testBeta()

    setChimpleSeed(0);

    N = 1000;
    results = zeros(N,1);
    alpha = 100;
    beta = 20;
    %sigma = 200;

    for i = 1:N
       results(i) = chimpBeta('foo',alpha,beta); 
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test the gen
    actualMean = sum(results)/length(results);
    expectedMean = alpha/(alpha+beta);
    assertTrue(abs(expectedMean-actualMean)<expectedMean*.05);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test the kernel
    handler = getMonkeyHandler();
    bhandler = handler.getBeta();
    
    for i = 1:N
        pair = bhandler.regenerate(.6,{alpha,beta,.1});
        results(i) = pair.getResult();
        H = pair.getHastings();
        assertEqual(H,0);
    end
    actualMean = sum(results)/length(results);
    expectedMean = .6;
    assertTrue(abs(actualMean-expectedMean) < .01);

    %calculate sample variance
    var = sum((results - actualMean).^2)/length(results);
    actualSigma = sqrt(var);
    expectedSigma = .1;
    assertTrue(abs(actualSigma-expectedSigma)<.05);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test the likelihood
    %chimpbeta_likelihood(.99,alpha,beta)
    x = .99;
    y = .9;
    a = bhandler.calculateLogLikelihood(x,{alpha,beta});
    b = bhandler.calculateLogLikelihood(y,{alpha,beta});


    %We take the difference in the log domain (ratio outside of log domain) so
    %that we can ignore the constant term.
    aexp = -(alpha-1)*log(x) - (beta-1)*log(1-x);
    bexp = -(alpha-1)*log(y) - (beta-1)*log(1-y);

    assertElementsAlmostEqual(a-b,aexp-bexp);
    
end
