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

function testSeed

firstNum0s = 0;
firstNum1s = 0;

for i = 1:10

    burnin = 10;
    samples = 100;
    spacing = 0;
    
    setChimpleSeed(0);
    
    results = chimplify(@biasprogram,burnin,samples,spacing);

    num1s = sum(cell2mat(results));
    num0s = samples - num1s;

    if i == 1
        firstNum0s = num0s;
        firstNum1s = num1s;
    else
        assertTrue(firstNum0s == num0s);
        assertTrue(firstNum1s ==  num1s);
    end
end
