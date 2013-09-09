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
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [retval]=medical_BN(observed_cough)
    %defines the probability of lung cancer to be 1%
    lung_cancer = chimpflip('LG' ,0.01);
    %defines the probability of cold cancer to be 20%
    cold=chimpflip ('cold',0.2);
    %cough is present if cold or lung cancer is present
    cough=or(cold, lung_cancer);
    %save the value of cough
    chimpconst ('cough',cough);
    %save the result of the observed cough
    chimpconst('observed_cough',observed_cough);
    %return lung cancer, cold, and cough
    retval = {lung_cancer,cold,cough};
end