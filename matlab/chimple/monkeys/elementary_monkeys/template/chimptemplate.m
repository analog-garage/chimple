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

function result = chimptemplate(name,param1,param2,param3)
      
    if nargin<4
        param3=0;
    end
    if nargin<3
        param2=0;
    end
    if nargin<2
        param1=0;
    end
    params=cell(3,1);
    params{1}=param1;
    params{2}=param2;
    params{3}=param3;

    result = runMonkey(@chimptemplate_gen,@chimptemplate_regen,@chimptemplate_likelihood,@chimptemplate_kernel,name,params);
    
end
