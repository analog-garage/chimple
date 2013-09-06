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

function testPerm

    setChimpleSeed(0);

    N = 3;
    M = 1000;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test gen
    counts = containers.Map();
    for i = 1:M
        p = chimpperm('foo',N);
        key = char(p+'a');
        if counts.isKey(key)
            counts(key) = counts(key)+1;
        else
            counts(key) = 1;
        end
    end

    assertEqual(factorial(N),length(counts));
    countVector = cell2mat(counts.values);
    countVector = countVector/sum(countVector);
    diff = norm(countVector - ones(1,length(countVector))/length(countVector));
    assertTrue(diff<.05);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test likelihood
    handler = getMonkeyHandler();
    p = handler.getPerm();
    
    likelihood = p.calculateLogLikelihood(int32(1:N),int32(N));
    assertEqual(likelihood,log(factorial(N)));


    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test kernel
    N = 5;
    M = 4000;
    counts = zeros(N);
    for i = 1:M
        pair = p.regenerate(int32(1:N),int32(N));
        tmp = reshape(pair.getResult(),1,N);
        hastings = pair.getHastings();
        assertEqual(hastings,0);
        tmp = find(tmp ~= 1:N);
        assertEqual(length(tmp),2);
        counts(tmp(1),tmp(2)) = counts(tmp(1),tmp(2))+1;
    end

    numNonZero = N*(N-1)/2;
    counts = counts / sum(sum(counts))*numNonZero;

    for i = 1:(N-1)
        for j = i+1:N
            assertTrue(abs(counts(i,j)-1)<.2);
        end
    end
end

