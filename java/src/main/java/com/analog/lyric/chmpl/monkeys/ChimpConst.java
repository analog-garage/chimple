package com.analog.lyric.chmpl.monkeys;

import com.analog.lyric.chmpl.ChimpleException;
import com.analog.lyric.chmpl.MonkeyHandler;

public class ChimpConst extends MonkeyBase
{

	public ChimpConst(MonkeyHandler handler) 
	{
		super(handler);
		// TODO Auto-generated constructor stub
	}

	@Override
	public Object generate(Object[] parameters)  
	{
		if (parameters.length != 1)
			throw new ChimpleException("expected one argument");
		// TODO Auto-generated method stub
		return parameters[0];
	}

	@Override
	public double calculateLikelihood(Object result, Object[] parameters) 
	{
		return 0;
	}

	@Override
	public RegeneratorPair regenerate(Object oldVal, Object[] parameters)  
	{
		if (parameters.length != 1)
			throw new ChimpleException("expected one argument");
		
		return new RegeneratorPair(parameters[0],0);
	}

}
