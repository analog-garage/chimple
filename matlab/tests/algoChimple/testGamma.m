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

function testGamma()

    setChimpleSeed(0);
    
    N = 3000;

    alpha = 4;
    beta = 5;
    results1 = zeros(N,1);
    results2 = zeros(N,1);

    r = com.analog.lyric.math.RandomPlus();

    for i = 1:N
        results1(i) = gammarng(alpha,beta,1);
        results2(i) = r.nextGamma(alpha,beta);
    end

    [x1,y1] = hist(results1);
    [x2,y2] = hist(results2);

    x1 = x1/sum(x1);
    x2 = x2/sum(x2);

    diff = x1-x2;

    assertTrue(norm(diff)<.4);
end
