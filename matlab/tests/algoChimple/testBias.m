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

function testBias()

global DIMPLE_TEST_VERBOSE;
if (~exist('DIMPLE_TEST_VERBOSE','var') || DIMPLE_TEST_VERBOSE); silent = false; else silent = true; end;

    tic

    burnin = 300;
    samples = 600;
    spacing = 0;
    results = chimplify(@biasprogram,burnin,samples,spacing);

    if (~silent)
        toc
    end

    num1s = sum(cell2mat(results));
    num0s = samples - num1s;

    if (~silent)
        num0s
        num1s
    end

    assertTrue(num0s > 200);
    assertTrue(num1s > 200);

    %results = cell2mat(results);

    %hist(results);
end

