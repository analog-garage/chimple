
import os
import sys


def setDimpleHome():
    dimple_home = os.environ.get("DIMPLE_HOME")
    if dimple_home is None:
        dimple_home = os.getcwd() + "/../../dimple"
        os.environ["DIMPLE_HOME"] = dimple_home
        if not os.path.isdir(dimple_home):
            print("DIMPLE_HOME not set and default directory of %s does not exist\n" % dimple_home)
            return 0

if __name__ == "__main__":

    setDimpleHome()
    sys.path.append(os.environ['DIMPLE_HOME'] + '/build')

    import buildutils

    builder = buildutils.Builder()
    javaBuildDir = '../java/'
    javaTargetDir = '../java/build/libs'
    progName = 'chimple'
    copyRoot = '..'
    pFileToCheck = ''
    buildCommand = 'gradle assemble'
    buildCommandWithTest = 'gradle'
    builder.build(sys.argv,__file__,'../VERSION',javaBuildDir,javaTargetDir,progName,copyRoot,pFileToCheck,
                  buildCommand,buildCommandWithTest)
    #build up parser and parse args




