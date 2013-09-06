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

public class ChimpRandn extends MonkeyBase 
{
	public ChimpRandn(MonkeyHandler handler) 
	{
		super(handler);
	}

	@Override
	public Object generate(Object[] parameters)  
	{
		double mu = (Double)parameters[0];
		double sigma = (Double)parameters[1];
		
		return getRandom().nextGaussian()*sigma+mu;
	}

	@Override
	public double calculateLogLikelihood(Object result, Object[] parameters) 
	{
		double value = (Double)result;
		double mu = (Double)parameters[0];
		double sigma = (Double)parameters[1];
		
		//1/sqrt(2*pi*sigma^2)*exp(-(mu-value)^2/(2*sigma^2))
		//log(sqrt(2*pi*sigma^2) + (mu-value)^2/(2*sigma^2)
		return Math.log(Math.sqrt(2*Math.PI*sigma*sigma)) + (mu-value)*(mu-value)/(2*sigma*sigma);
	}

	@Override
	public RegeneratorPair regenerate(Object oldVal, Object[] parameters)  
	{
		double mu = (Double)oldVal;
		double sigma2 = (Double)parameters[2];
		return new RegeneratorPair(getRandom().nextGaussian()*sigma2 + mu,0);
	}

}
