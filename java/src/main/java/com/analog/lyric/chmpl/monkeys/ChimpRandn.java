package com.analog.lyric.chmpl.monkeys;

import com.analog.lyric.chmpl.MonkeyHandler;

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
	public double calculateLikelihood(Object result, Object[] parameters) 
	{
		double value = (Double)result;
		double mu = (Double)parameters[0];
		double sigma = (Double)parameters[1];
		
		//1/sqrt(2*pi*sigma^2)*exp(-(mu-value)^2/(2*sigma^2))
		//log(sqrt(2*pi*sigma^2) + (mu-value)^2/(2*sigma^2)
		// TODO Auto-generated method stub
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
