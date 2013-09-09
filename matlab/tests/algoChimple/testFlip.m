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

function testFlip()

    setChimpleSeed(0);
    N = 1000;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test gen
    p = rand();
    successes = 0;
    for i = 1:N
        tmp = chimpFlip('foo',p);
        successes = successes+tmp;
    end
    assertTrue(abs(p-successes/N) < p*.05);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test regen
    handler = getMonkeyHandler();
    flip = handler.getFlip();
    for i = 1:N
        value = rand < .5;
        pair = flip.regenerate(int32(value),{p});
        result = pair.getResult();
        hastings = pair.getHastings();
        assertEqual(result,double(~value));
        assertEqual(hastings,0);
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Test likelihood
    actual = flip.calculateLogLikelihood(int32(1),{p});
    expected = -log(p);
    assertEqual(actual,expected);


    actual = flip.calculateLogLikelihood(int32(0),{p});
    expected = -log(1-p);
    assertEqual(actual,expected);

end
