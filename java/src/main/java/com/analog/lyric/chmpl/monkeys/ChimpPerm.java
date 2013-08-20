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

package com.analog.lyric.chmpl.monkeys;

import com.analog.lyric.chmpl.MonkeyHandler;

public class ChimpPerm extends MonkeyBase 
{

	public ChimpPerm(MonkeyHandler handler) {
		super(handler);
	}

	@Override
	public Object generate(Object[] parameters)  
	{
		int n = (Integer)parameters[0];
		return getRandom().nextPermutation(n);
	}

	@Override
	public double calculateLikelihood(Object result, Object[] parameters) 
	{
		int n = (Integer)parameters[0];
		//prob = 1/factorial(n)
		//-log = log(factorial(n))
		return com.analog.lyric.math.Functions.logfactorial(n);
	}

	@Override
	public RegeneratorPair regenerate(Object oldVal, Object[] parameters)  
	{
		int [] value = (int[])oldVal;
		int n = (Integer)parameters[0];
		
		int [] newval = new int[value.length];
		
		for (int i = 0; i < newval.length; i++)
		{
			newval[i] = value[i];
		}
		
		int ii = 0;
		int jj = 0;
		
		while (ii == jj)
		{
			ii = Math.abs(getRandom().nextInt())%n;
			jj = Math.abs(getRandom().nextInt())%n;
		}
		
		int tmp = newval[ii];
		newval[ii] = newval[jj];
		newval[jj] = tmp;
		
		return new RegeneratorPair(newval,0);
	}

	
	
}
