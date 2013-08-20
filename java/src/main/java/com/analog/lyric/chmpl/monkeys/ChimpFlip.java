package com.analog.lyric.chmpl.monkeys;

import com.analog.lyric.chmpl.MonkeyHandler;

/*
 * A random monkey that generates a 1 or 0
 * according to a weight.
 */
public class ChimpFlip extends MonkeyBase 
{

	public ChimpFlip(MonkeyHandler handler) 
	{
		super(handler);
		// TODO Auto-generated constructor stub
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
	public double calculateLikelihood(Object result, Object[] parameters) 
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
