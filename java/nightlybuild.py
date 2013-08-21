################################################################################
#   Copyright 2012 Analog Devices, Inc.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#################################################################################
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

if __name__ == '__main__':

    
    setDimpleHome()
    sys.path.append(os.environ['DIMPLE_HOME'] + '/solvers/java')
    sys.path.append('../nightlybuildtools')

    import bee
    
    bee.bee(sys.argv)


