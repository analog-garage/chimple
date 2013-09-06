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

function testRandn()

    setChimpleSeed(0);

    mu = 2;
    sigma = .7;
    N = 1000;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test gen
    results = zeros(N,1);
    for i = 1:N
        results(i) = chimprandn('foo',mu,sigma);
    end


    %hist(results);
    compareMeanAndVariance(results,mu,sigma^2);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test regen
    %function [result,hastings]= chimprandn_kernel(oldvalue,mu,sigma,sigma2)
    handler = getMonkeyHandler();
    r = handler.getRandn();
    
    sigma2 = .5;
    for i = 1:N
       pair = r.regenerate(mu+1,{mu,sigma,sigma2}); 
       result = pair.getResult();
       hastings = pair.getHastings();
       assertEqual(hastings,0);

       results(i) = result;
    end

    compareMeanAndVariance(results,mu+1,sigma2^2);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test likelihood
    %1/sqrt(2*pi*sigma)*exp(-(u-sample)^2/2*sigma^2)
    %-log(1/sqrt(2*pi*sigma^2)*exp(-(u-sample)^2/2*sigma^2))
    %log(sqrt(2*pi*sigma^2)) + (u-sample)^2/(2*sigma^2)
    sample = rand()+mu;
    ll = r.calculateLogLikelihood(sample,{mu,sigma,sigma2});
    ell = log(sqrt(2*pi*sigma^2)) + (mu-sample)^2/(2*sigma^2);
    assertElementsAlmostEqual(ll,ell);
end
