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

import com.analog.lyric.chimple.ChimpleException;
import com.analog.lyric.chimple.MonkeyHandler;
import com.analog.lyric.chimple.MonkeyOutput;
import com.analog.lyric.math.RandomPlus;

import java.util.Arrays;

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
	public abstract double calculateLogLikelihood(Object result, Object [] parameters);
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
	
	protected boolean paramatersAreSame(Object [] params1, Object [] params2)
	{
		return Arrays.deepEquals(params1, params2);
	}
	
	public Object runMonkey(String name, Object ... parameters) 
	{
		
		_monkeyHandler.plusplus();
		
		//Check to see if we're running Metropolis Hastings or just running
		//forwards
		if (!_monkeyHandler.getMHMode())
		{
			//If we're just running forwards, just regenerate the value.
			return generate(parameters);
		}
		else
		{
			//We're running metropolis hasings
			
			//What run is this?
			int runNumber = _monkeyHandler.getRunNumber();
			
			//See if a monkey by this name exists
			MonkeyOutput monkey = _monkeyHandler.getMonkeyByName(name);
			
			if (monkey != null)
			{
				//A monkey by this name already exists
				
				//If this variable was already created this run, throw an error.
				if (monkey.getLastTouched() == runNumber)
					throw new ChimpleException("Variable (" + name + ") already created");
				
				//Check to see if this is the monkey we chose to resample.
				if (monkey.getIsChosenOne())
				{
					//It is.
					
					//Retrieve the old value and old log likelihood
					Object oldVal = monkey.getValue();
					double oldll = monkey.getLogLikelihood();
					
					//Regenerat a new value.
					RegeneratorPair pair = regenerate(oldVal, parameters);
					
					//Calculate the new log likelihood.
					double likelihood = calculateLogLikelihood(pair.getResult(), parameters);
					
					//Set the value, the log likelihood, and the new run number
					monkey.setValueAndLogLikelihood(pair.getResult(),likelihood,runNumber);
					
					//Set the hastings value.
					_monkeyHandler.setHastings(likelihood-oldll+pair.getHastings());
				
					return pair.getResult();
				}
				else
				{
					//This is not the chosen one.
					
					//Check to see if we've already encountered these parameters
					if (paramatersAreSame(parameters,monkey.getParameters()))
					{						
						//If we have, return the existing value
		                Object result = monkey.getValue();
		                
		                //TODO: Why do we have to do this, why would the likelihood have changed?
		                //     The parameters and the result are the same.
		                double likelihood = calculateLogLikelihood(result,parameters);
		                monkey.setLogLikelihood(likelihood,runNumber);
		                return result;
					}
					else
					{
						//In the case where the parameters are not the same, we're going to
						//regenerate.  This is "weak" stochastic re-use.  
						
						//regenerate.
						Object result = generate(parameters);
						
						//calculate the likelihood and store the value and likelihood.
						double likelihood = calculateLogLikelihood(result, parameters);
		                monkey.setValueAndLogLikelihood(result,likelihood,runNumber);
		                monkey.setParameters(parameters);
		                return result;

					}
				}
			}
			else
			{
				//This is the first time this monkey name has been encountered.
				
				//Generate the variable
				Object result = generate(parameters);
				
				//calculate the likelihood and add the monkey to the list of monkeys.
				double likelihood = calculateLogLikelihood(result,parameters);
				_monkeyHandler.addMonkey(name,result,likelihood,runNumber,parameters);
				return result;
			}
			

		}
	}
}
