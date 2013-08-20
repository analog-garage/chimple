%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright 2012 Analog Devices, Inc.
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%
%       http://www.apache.org/licenses/LICENSE-2.0
%
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
%   implied. See the License for the specific language governing
%   permissions and limitations under the License.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function failed = testChimple(varargin)

    % 
    % testChimple: top level chimple test script. 
    %   
    %   ==Running== 
    %
    %   >> testDimple
    %   
    %   OR
    %
    %   >> testDimple('log', 1)

    all_algo = 0;
    one_algo = 0;
    args = {};
    index = 1;
    for i = 1:length(varargin)
        if isequal('all_algo',varargin{i});
            all_algo = 1;
        else
            args{index} = varargin{i};
            index = index+1;
        end
        if isequal('one_algo',varargin{i});
            one_algo = 1;
        end
    end
    
    if ~all_algo && ~one_algo
        args{length(args)+1} = 'one_algo';
        args{length(args)+1} = 'Chimple';
    end
    
    failed = testDimple(args{:});
