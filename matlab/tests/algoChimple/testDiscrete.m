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

function testDiscrete()

    N = 3;
    M = 1000;
    setChimpleSeed(0);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %test gen
    probs = rand(1,N);
    alphabet = cell(N,1);
    for i = 1:N
       alphabet{i} = char('a' + i-1);
    end

    results = zeros(M,1);
    for i = 1:M
        tmp = chimpDiscrete('foo',probs,alphabet);
        results(i) = tmp-'a'+1;
    end


    [a,b]=hist(results,unique(results));

    norma = a/sum(a);
    normprobs = probs / sum(probs);
    %norma
    %normprobs
    diff = norm(norma-normprobs);
    assertTrue(diff<.1);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %test likelihood
    handler = getMonkeyHandler();
    d = handler.getDiscrete();
    HT = java.util.HashMap();
    for i = 1:N
       HT.put(char('a'+i-1),int32(i-1)); 
    end
    results = zeros(1,N);
    for i = 1:N
        results(i) = d.calculateLogLikelihood(char('a'+i-1),{probs,alphabet,HT});
    end

    assertEqual(probs,results);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %test regen
    probs = rand(1,N);
    alphabet = cell(N,1);
    for i = 1:N
       alphabet{i} = char('a' + i-1);
    end

    results = zeros(M,1);
    for i = 1:M
        pair = d.regenerate([],{probs,alphabet,HT});
        tmp = pair.getResult();
        H = pair.getHastings();
        assertEqual(H,0);
        results(i) = tmp-'a'+1;
    end


    [a,b]=hist(results,unique(results));

    norma = a/sum(a);
    normprobs = probs / sum(probs);
    %norma
    %normprobs
    diff = norm(norma-normprobs);
    assertTrue(diff<.1);
end
