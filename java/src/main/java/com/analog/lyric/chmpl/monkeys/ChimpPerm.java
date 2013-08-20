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
