package com.analog.lyric.chmpl.monkeys;

import org.apache.commons.math.special.Gamma;

import com.analog.lyric.chmpl.MonkeyHandler;

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
	public double calculateLikelihood(Object result, Object[] parameters) 
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
