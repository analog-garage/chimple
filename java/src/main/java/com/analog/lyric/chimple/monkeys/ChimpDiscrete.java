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

import java.util.HashMap;

import com.analog.lyric.chimple.MonkeyHandler;

public class ChimpDiscrete extends MonkeyBase 
{
	
	public ChimpDiscrete(MonkeyHandler handler) 
	{
		super(handler);
	}

	@Override
	public Object generate(Object[] parameters)  
	{
		//name,probabilities,sampled_set)
		double [] probs = (double[])parameters[0];
		Object [] set = (Object[])parameters[1];
		return set[pickNumber(probs)];
	}

	@Override
	public double calculateLogLikelihood(Object result, Object[] parameters) 
	{
		//value, probs, set, dictionary
		double [] probs = (double[])parameters[0];
		@SuppressWarnings("unchecked")
		HashMap<Object,Integer> map = (HashMap<Object,Integer>)parameters[2];
		
		//convert the result to an index
		//return the probability for that index
		return probs[map.get(result)];
	}

	@Override
	public RegeneratorPair regenerate(Object oldVal, Object[] parameters)  
	{
		return new RegeneratorPair(generate(parameters),0);
	}
	
	public int pickNumber(double [] probs)
	{
		double sum = 0;
		for (int i = 0; i < probs.length; i++)
			sum += probs[i];
		
		double tmp = getRandom().nextDouble();

		double total = 0;
		for (int i = 0; i < probs.length; i++)
		{
			total += probs[i]/sum;
			
			if (tmp < total)
				return i;
		}
		
		return probs.length-1;
	}

}
