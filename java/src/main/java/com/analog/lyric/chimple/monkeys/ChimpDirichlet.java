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

import org.apache.commons.math.special.Gamma;

import com.analog.lyric.chimple.MonkeyHandler;

public class ChimpDirichlet extends MonkeyBase
{
	
	public ChimpDirichlet(MonkeyHandler handler) 
	{
		super(handler);		
	}

	@Override
	public Object generate(Object[] parameters)  
	{
		double [] alphas = (double[])parameters[0];
		return getRandom().nextDirichlet(alphas);
	}

	@Override
	public double calculateLogLikelihood(Object result, Object[] parameters) 
	{
		double [] alphas = (double[])parameters[0];
		double [] value = (double[])result;
		
		double retval = 0;
		
		double sum = 0;
		for (int i = 0; i < alphas.length; i++)
		{
			retval -= (alphas[i]-1)*Math.log(value[i]);
			retval += Gamma.logGamma(alphas[i]);
			sum += alphas[i];
		}
		
		retval -= Gamma.logGamma(sum);
		
	    //result=sum(gammaln(alphas))-gammaln(sum(alphas))-sum((alphas-1).*log(value));

		return retval;
	}

	@Override
	public RegeneratorPair regenerate(Object oldVal, Object[] parameters)  
	{
		double [] prev = (double[])oldVal;

		int ii = 0;
		int jj = 0;
		
		while (ii == jj)
		{
			ii = getRandom().nextInt(prev.length);
			jj = getRandom().nextInt(prev.length);
		}
		
		double [] retval = prev.clone();
		
		double a = retval[ii];
		double b = retval[jj];
		double total = a+b;
		
		double ap = getRandom().nextDouble()*total;
		double bp = total-ap;
		
		retval[ii] = ap;
		retval[jj] = bp;
		
		return new RegeneratorPair(retval,0);
	}

}
