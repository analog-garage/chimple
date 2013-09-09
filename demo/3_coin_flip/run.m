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

global CHIMPLE_TEST_DEMOS_RUNNING
if isempty(CHIMPLE_TEST_DEMOS_RUNNING)
    CHIMPLE_TEST_DEMOS_RUNNING = false;
end

burnin = 100;
samples = 100;
spacing = 5;
sum_val = 15;
results = chimplify (@randomcoin , burnin , samples , spacing ,{sum_val} , @costfunction);
res = cell2mat(results); 

if ~CHIMPLE_TEST_DEMOS_RUNNING
    hist(res);
end