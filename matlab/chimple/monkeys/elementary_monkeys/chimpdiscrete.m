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

function result = chimpdiscrete(name,probabilities,sampled_set)
      
    if nargin < 3
        sampled_set = 1:length(probabilities);
    end
    
    if length(probabilities)~=length(sampled_set)
        error('The sampled set and probability vector must have identical length');
    end
    
    if isnumeric(sampled_set)
        sampled_set=num2cell(sampled_set);
    end
    
    if nargin <2
        error('please provide probabilities');
    end
    
        
    %params=cell(3,1);
    %params{1}=probabilities;
    %params{2}=sampled_set;
    handler = getMonkeyHandler();
    result = handler.chimpDiscrete(name,probabilities,sampled_set);

end
