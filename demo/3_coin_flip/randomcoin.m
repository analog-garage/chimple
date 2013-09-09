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

function [out]=randomcoin(sum_observed)
 
% Generates a random weight for a coin
    weight=chimpRand('weight');
    for i=1:20
      % given an input weight, creates a coin which flips heads with
      % probability equal to weight
      X(i)=chimpFlip(sprintf('X%d',i),weight);
    end
    out=weight;
    sumout=sum(X);
    chimpConst('sumvar',sumout);
    chimpConst('sum_observed',sum_observed);
    