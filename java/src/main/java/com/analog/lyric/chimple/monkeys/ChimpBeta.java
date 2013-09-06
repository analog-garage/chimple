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

import org.apache.commons.math.special.Gamma;

public class ChimpBeta extends MonkeyBase 
{

	public ChimpBeta(MonkeyHandler handler) 
	{
		super(handler);
	}

	@Override
	public Object generate(Object[] parameters)  
	{
		
		double alpha = (Double)parameters[0];
		double beta = (Double)parameters[1];
		
		double [] tmp = getRandom().nextDirichlet(new double [] {alpha,beta});
		return tmp[0];
	}

	@Override
	public double calculateLogLikelihood(Object result, Object[] parameters) 
	{
		/*
		 *     alphas=[alpha beta];
    value=[value 1-value];
    %fast computation without normalization
    %result=-sum((alphas-1).*log(value));
    
    %exact computation, but the constant term should hopefully be useless
    
    result=sum(gammaln(alphas))-gammaln(sum(alphas))-sum((alphas-1).*log(value));

		 */
		double value = (Double)result;
		double alpha = (Double)parameters[0];
		double beta = (Double)parameters[1];

		
		//double alphaBetaSum = alpha+beta;

		double retval = Gamma.logGamma(alpha);
		retval +=  Gamma.logGamma(beta);
		retval -= Gamma.logGamma(alpha+beta);
		retval -= (alpha-1)*Math.log(value);
		retval -= (beta-1)*Math.log(1-value);
		

		return retval;
	}

	@Override
	public RegeneratorPair regenerate(Object oldVal, Object[] parameters)  
	{
		double sigma = (Double)parameters[2];
		double hastings = 0;
		double value = Math.min(Math.max((Double)oldVal+sigma*getRandom().nextGaussian(),0), 1);
		return new RegeneratorPair(value,hastings);
	}

}
