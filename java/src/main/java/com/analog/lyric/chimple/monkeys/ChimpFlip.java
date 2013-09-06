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

package com.analog.lyric.chimple.monkeys;

import com.analog.lyric.chimple.MonkeyHandler;

/*
 * A random monkey that generates a 1 or 0
 * according to a weight.
 */
public class ChimpFlip extends MonkeyBase 
{

	public ChimpFlip(MonkeyHandler handler) 
	{
		super(handler);
	}

	@Override
	public Object generate(Object[] parameters) 
	{
		double weight = .5;
		if (parameters.length == 1)
		{
			weight = (Double)parameters[0];
		}
		if (getRandom().nextDouble() < weight)
			return 1;
		else
			return 0;
	}

	@Override
	public double calculateLogLikelihood(Object result, Object[] parameters) 
	{
		int value = (Integer)result;
		double weight = (Double)parameters[0];
		
		if (value != 0)
			return -Math.log(weight);
		else
			return -Math.log(1-weight);
	}

	@Override
	public RegeneratorPair regenerate(Object oldVal, Object[] parameters) 
	{
		
		//double weight = (Double)parameters[0];
		int result = (Integer)oldVal;
		//int newresult= (Integer) (1-result);
		//double ratio= -(2*newresult-1)*Math.log(weight);
		double ratio=0;
		return new RegeneratorPair(1-result, ratio);
	}

}
