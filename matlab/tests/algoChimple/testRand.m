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

function testRand()

    N = 1000;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %gen
    results = zeros(N,1);
    for i = 1:N
        results(i) = chimprand('foo');
    end

    expectedMean = .5;
    
    compareMeanAndVariance(results,expectedMean,1/12);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %regen
    handler = getMonkeyHandler();
    r = handler.getRand();

    results = zeros(N,1);
    for i = 1:N
         pair = r.regenerate(rand(),{});
         results(i) = pair.getResult();
         assertEqual(pair.getHastings(),0);
    end

    compareMeanAndVariance(results,expectedMean,1/12);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %likelihood
    assertEqual(0,r.calculateLikelihood(rand(),{}));

end
