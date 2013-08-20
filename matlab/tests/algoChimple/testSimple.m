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

function testSimple()

    burnin = 10;
    samples = 20;
    spacing = 30;
    arg = rand();
    global count___;
    count___ = 0;

    results = chimplify(@simpleProgram,burnin,samples,spacing,{arg});

    %First test that the counts are correct
    assertTrue(length(results)==samples);
    for i = 1:length(results)
        tmp = results{i};

        %verify correct spacing and burnin
        assertTrue(tmp{1}==(i-1)*(spacing+1)+burnin);

        %verify arguments are passed
        assertTrue(tmp{2}==arg);
    end

end

%Test that likelhood is valid?

%verify hard constraint

%verify soft constraint gets us in right neighborhood.

%test all distributions

%test all other math calculations


