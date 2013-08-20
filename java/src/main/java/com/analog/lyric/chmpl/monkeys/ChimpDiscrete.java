package com.analog.lyric.chmpl.monkeys;

import java.util.HashMap;

import com.analog.lyric.chmpl.MonkeyHandler;

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
	public double calculateLikelihood(Object result, Object[] parameters) 
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
