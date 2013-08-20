package com.analog.lyric.chmpl.monkeys;

import com.analog.lyric.chmpl.MonkeyHandler;

/*
 * A random monkey that generates a uniform distribution between 0 and 1.
 */
public class ChimpRand extends MonkeyBase
{

	public ChimpRand(MonkeyHandler handler) 
	{
		super(handler);
	}

	@Override
	public Object generate(Object[] parameters) 
	{
		return getRandom().nextDouble();
	}

	@Override
	public double calculateLikelihood(Object result, Object[] parameters) 
	{
		return 0;
	}

	@Override
	public RegeneratorPair regenerate(Object oldVal, Object[] parameters) 
	{
		return new RegeneratorPair(getRandom().nextDouble(),0);
	}

}
