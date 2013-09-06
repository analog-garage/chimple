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

function [results,likelihoods] = chimplify(program,burnin,numsamples,spacing,arguments,costfunction)
    %Arguments:
    % program - The chmpl program
    % burnin - how many samples to throw away before starting to record
    % samples.
    % numsamples - numsamples to record.
    % spacing - how many samples to skip between samples you keep.
    % arguments - arguments to the program (pass in as cell array)
    % costfunction - ???

    if nargin<4
        error('Not enough arguments');
    end


    if nargin<5
        arguments={};
    end
    if burnin < 0
        error('ack');
    end
    
    if nargin < 6
        costfunction = [];
    end


    %TODO: tell java you're about to run
    monkeyHandler = getMonkeyHandler();
    monkeyHandler.startChimplify();

    results = cell(numsamples,1);
    likelihoods = zeros(numsamples,1);
    
    ct=0;
    for i = 1:burnin
        if ct==20
            fprintf('burnin iteration %d\n',i);
            ct=0;
        end
        runProgram(program,arguments,monkeyHandler,costfunction);
        ct=ct+1;
    end

    for i = 1:length(results)
        if ct==20
            fprintf('Sample generation number %d\n',i);
            ct=0;
        end
        ct=ct+1;

        [result,ll] = runProgram(program,arguments,monkeyHandler,costfunction);

        results{i} = result;
        likelihoods(i)= ll;

        if i ~= length(results)
            for j = 1:spacing
                runProgram(program,arguments,monkeyHandler,costfunction);
            end
        end

    end

    %TODO: tell java we're done running
    monkeyHandler.endChimplify();

end


function [result,ll] = runProgram(program,arguments,monkeyHandler,costfunction)

    oldCount = monkeyHandler.startRunProgram();
    
    result = program(arguments{:});

    if ~isempty(costfunction)
        if iscell(result)
            addChimpCost(costfunction(result{:}));
        else
            addChimpCost(costfunction(result));
        end
    end
    
    
    monkeyHandler.endRunProgram(oldCount,result);
    result = monkeyHandler.getResult();
    
    %Do this recursively
    result = convert_to_cell(result);
    ll = monkeyHandler.getLikelihood();


end

function retval = convert_to_cell(obj)
    if isa(obj,'java.lang.Object[]')
        obj = cell(obj);
        for i = 1:length(obj)
           obj{i} = convert_to_cell(obj{i}); 
        end
    end

    retval = obj;
end
