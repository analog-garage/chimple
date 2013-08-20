package com.analog.lyric.chmpl.monkeys;

import com.analog.lyric.chmpl.ChimpleException;
import com.analog.lyric.chmpl.MonkeyHandler;
import com.analog.lyric.chmpl.MonkeyOutput;
import com.analog.lyric.math.RandomPlus;

/*
 * This is the base class for all elementary random monkeys.  The runMoneky method
 * is responsible for either generating new data, regenerating data, or retrieving the last generated
 * data.
 * 
 * Children must override generate, regenerate, and calculateLikelihood.
 */
public abstract class MonkeyBase 
{
	private MonkeyHandler _monkeyHandler;
	
	public MonkeyBase(MonkeyHandler handler)
	{
		_monkeyHandler = handler;
	}
	
	public RandomPlus getRandom()
	{
		return _monkeyHandler.getRandom();
	}
	
	public abstract Object generate(Object [] parameters) ;
	public abstract double calculateLikelihood(Object result, Object [] parameters);
	public abstract RegeneratorPair regenerate(Object oldVal, Object [] parameters) ;
	
	public class RegeneratorPair
	{
		private Object _result;
		private double _hastings;
		
		public RegeneratorPair(Object value, double hastings)
		{
			_result = value;
			_hastings = hastings;
		}
		public Object getResult()
		{
			return _result;
		}
		public double getHastings()
		{
			return _hastings;
		}
	}
	
	private boolean paramatersAreSame(Object [] params1, Object [] params2)
	{
		
		if (params1.length != params2.length)
			return false;
		
		for (int i = 0; i < params1.length; i++)
		{
			if (!params1[i].equals(params2[i]))
			{
				return false;
			}
		}
		
		return true;
	}
	
	public Object runMonkey(String name, Object ... parameters) 
	{
		
		_monkeyHandler.plusplus();
		
		if (!_monkeyHandler.getMHMode())
		{
			return generate(parameters);
		}
		else
		{
			int runNumber = _monkeyHandler.getRunNumber();
			
			MonkeyOutput monkey = _monkeyHandler.getMonkeyByName(name);
			
			if (monkey != null)
			{
				if (monkey.getLastTouched() == runNumber)
					throw new ChimpleException("Variable (" + name + ") already created");
				
				if (monkey.getIsChosenOne())
				{
					Object oldVal = monkey.getValue();
					double oldll = monkey.getLikelihood();
					RegeneratorPair pair = regenerate(oldVal, parameters);
					double likelihood = calculateLikelihood(pair.getResult(), parameters);
					monkey.setValueAndLikelihood(pair.getResult(),likelihood,runNumber);
					_monkeyHandler.setHastings(likelihood-oldll+pair.getHastings());
				
					return pair.getResult();
				}
				else
				{
					
					if (paramatersAreSame(parameters,monkey.getParameters()))
					{
		                Object result = monkey.getValue();
		                double likelihood = calculateLikelihood(result,parameters);
		                monkey.setLikelihood(likelihood,runNumber);
		                return result;
					}
					else
					{
						Object result = generate(parameters);
						double likelihood = calculateLikelihood(result, parameters);
		                monkey.setValueAndLikelihood(result,likelihood,runNumber);
		                monkey.setParameters(parameters);
		                return result;

					}
				}
			}
			else
			{
				Object result = generate(parameters);
				double likelihood = calculateLikelihood(result,parameters);
				_monkeyHandler.addMonkey(name,result,likelihood,runNumber,parameters);
				return result;
			}
			

		}
	}
}
