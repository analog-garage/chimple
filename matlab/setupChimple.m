function setupChimple()

    %execute Dimpl startup
    if ~exist('testDimple')
        p = pwd;
        cd(fullfile('..', '..', 'Dimple'));
        startup;
        cd(p);
    end
    
    thisDir = fileparts(mfilename('fullpath'));

    %add java stuff to path
    JavaBuildDir = fullfile(thisDir, '..', 'java', 'build');
    JavaClassDir = fullfile(JavaBuildDir, 'classes', 'main');
    chimpleJar = fullfile(thisDir, '..', 'lib', 'chimple.jar');
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
