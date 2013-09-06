/*******************************************************************************
*   Copyright 2013 Analog Devices Inc.
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
********************************************************************************/

package com.analog.lyric.chimple;

import com.analog.lyric.chimple.ChimpleProgram;

/*
 * This is an exmaple of a chimple program.  The BiasTest
 * actually instantiates this and calls chimplify.
 */
public class MyBiasProgram extends ChimpleProgram 
{

	@Override
	public Object run(Object ... args)  
	{
		int S = chimpFlip("S");

		if (S == 1)
		{
			chimpRand("X2");
			chimpRand("X3");
			chimpRand("X4");
			chimpRand("X5");
		}
		
		addCost(-Math.log(1));
		
		return S;
	}

}
