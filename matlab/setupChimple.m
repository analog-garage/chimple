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

function setupChimple()

    %execute Dimpl startup
    if ~exist('testDimple')
        p = pwd;
        cd(fullfile('..',  'dimple'));
        startup;
        cd(p);
    end
    
    thisDir = fileparts(mfilename('fullpath'));

    %add java stuff to path
    JavaBuildDir = fullfile(thisDir, '..', 'java', 'build');
    JavaClassDir = fullfile(JavaBuildDir, 'classes', 'main');
    chimpleJar = fullfile(thisDir, '..', 'lib', ['chimple-' chimpleVersionNumber() '.jar']);
    if exist(JavaClassDir, 'dir')
        javaaddpath(JavaClassDir);
    elseif exist(chimpleJar)
        javaaddpath(chimpleJar,'-end');
    else
        error('Chimple has not been built');
    end

    TestClassDir = fullfile(JavaBuildDir, 'classes', 'test');
    if exist(TestClassDir, 'dir')
        javaaddpath(TestClassDir);
    end
    
    %add matlab stuff to path
    addpath(thisDir);
    addpath(genpath(fullfile(thisDir, 'chimple')));
    

    %add testDir to Dimpl testdir (make sure robust against clear all / clear classes)
    addDimpleTestDir(fullfile(thisDir, 'tests'));
    
end

