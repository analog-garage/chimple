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

package com.analog.lyric.chimple;

import java.util.ArrayList;
import java.util.HashMap;

import com.analog.lyric.chimple.monkeys.ChimpBeta;
import com.analog.lyric.chimple.monkeys.ChimpConst;
import com.analog.lyric.chimple.monkeys.ChimpDirichlet;
import com.analog.lyric.chimple.monkeys.ChimpDiscrete;
import com.analog.lyric.chimple.monkeys.ChimpFlip;
import com.analog.lyric.chimple.monkeys.ChimpPerm;
import com.analog.lyric.chimple.monkeys.ChimpRand;
import com.analog.lyric.chimple.monkeys.ChimpRandn;
import com.analog.lyric.math.RandomPlus;

/*
 * This is the main Chimple class.
 * 
 * This class follows the template pattern.  Users can create a new class
 * that derives from this one, implement the run method, and then call chimplify
 * to run Chimple.  ChimpleProgram provides a set of Elementary Random Monkeys that can
 * be used in the user's program.
 */
public abstract class ChimpleProgram 
{

	private MonkeyHandler _monkeyHandler;
	private double _savedLoglikelihood;
	private Object _savedResult;	
	private RandomPlus _random;
	private ChimpFlip _flip;
	private ChimpRand _rand;
	private ChimpConst _const;
	private ChimpRandn _randn;
	private ChimpDiscrete _discrete;
	private ChimpPerm _perm;
	private ChimpBeta _beta;
	private ChimpDirichlet _dirichlet;
	
	public ChimpleProgram()
	{
		_random = new RandomPlus();
		_monkeyHandler = new MonkeyHandler(_random);
		_flip = new ChimpFlip(_monkeyHandler);
		_rand = new ChimpRand(_monkeyHandler);
		_const = new ChimpConst(_monkeyHandler);
		_randn = new ChimpRandn(_monkeyHandler);
		_discrete = new ChimpDiscrete(_monkeyHandler);
		_perm = new ChimpPerm(_monkeyHandler);
		_beta = new ChimpBeta(_monkeyHandler);
		_dirichlet = new ChimpDirichlet(_monkeyHandler);
	}
	
	public ChimpFlip getFlip()
	{
		return _flip;
	}
	
	public ChimpRand getRand()
	{
		return _rand;
	}
	
	public ChimpRandn getRandn()
	{
		return _randn;
	}
	
	public ChimpDirichlet getDirichlet()
	{
		return _dirichlet;
	}
	
	public ChimpBeta getBeta()
	{
		return _beta;
	}
	
	public ChimpDiscrete getDiscrete()
	{
		return _discrete;
	}
	
	public ChimpPerm getPerm()
	{
		return _perm;
	}
	
	public MonkeyHandler getMonkeyHandler()
	{
		return _monkeyHandler;
	}
	
	public void setSeed(long seed)
	{
		_random.setSeed(seed);
	}
	
	public Object getResult()
	{
		return _savedResult;
	}
	public double getLikelihood()
	{
		return _savedLoglikelihood;
	}
	
	public abstract Object run(Object ... args) ;
	
	public double chimpRand(String name) 
	{
		return (Double)_rand.runMonkey(name, new Object[]{});
	}
	
	public int [] chimpPerm(String name, int n) 
	{
		return (int[])_perm.runMonkey(name,new Object[]{n});
	}
	
	public double [] chimpDirichlet(String name, double [] alphas) 
	{
		return (double[])_dirichlet.runMonkey(name,alphas);
	}
	
	public double chimpBeta(String name, double alpha, double beta) 
	{
        double sigma = 1.0/5.0*alpha/(Math.pow((alpha+1.0),2.0)*(alpha+2.0));
        return chimpBeta(name,alpha,beta,sigma);
	}
	
	public double chimpBeta(String name, double alpha, double beta, double sigma) 
	{
		return (Double)_beta.runMonkey(name,alpha,beta,sigma);
	}
	
	public Object chimpDiscrete(String name,double [] probabilities, Object [] values) 
	{
		HashMap<Object,Integer> map = new HashMap<Object,Integer>();
		for (int i = 0; i < values.length; i++)
		{
			if (map.containsKey(values[i]))
				throw new ChimpleException("duplicate elements found in sampled set");
			map.put(values[i],i);
		}
		return _discrete.runMonkey(name,new Object[]{probabilities,values,map});
	}
	
	public double chimpRandn(String name, double mu, double sigma) 
	{
		return chimpRandn(name,mu,sigma,sigma/10);
	}

	public double chimpRandn(String name, double mu, double sigma, double sigma_regen) 
	{
		return (Double)_randn.runMonkey(name, mu,sigma,sigma_regen);
	}
	
	public int chimpFlip(String name) 
	{
		return chimpFlip(name,.5);
	}
	
	public Object chimpConst(String name,Object value) 
	{
		return _const.runMonkey(name, value);
	}
	
	
	public int chimpFlip(String name, double weight) 
	{
		 Object tmp = _flip.runMonkey(name, new Object[]{weight});
		 return (Integer)tmp;
	}
	
	public Object getValue(String name)
	{
		//TODO: do I need to check that it's an active monkey?
		
		return _monkeyHandler.getMonkeyByName(name).getValue();
	}
	
	public void addCost(double value)
	{
		_monkeyHandler.addCost(value);
	}
	
	public void startChimplify()
	{
		//should return results and likelihood
		
		
		_savedLoglikelihood = Double.POSITIVE_INFINITY;
		_savedResult = null;
		
		_monkeyHandler.init();
		_monkeyHandler.setMHMode(true);
	}
	
	public void endChimplify()
	{
		_monkeyHandler.setMHMode(false);
	}
	
	public int startRunProgram()
	{
		_monkeyHandler.prepareForRun();
		int oldCount = _monkeyHandler.getActiveMonkeyNum();
		_monkeyHandler.resetNum();
		return oldCount;
	}
	
	public void endRunProgram(int oldCount, Object result)
	{
		int newCount = _monkeyHandler.getActiveMonkeyNum();
		ArrayList<Double> constraints = _monkeyHandler.getCosts();
		double hastings = _monkeyHandler.getHastings();
		
		double newll = 0;
		
		for (double c : constraints)
			newll += c;
		
		boolean accept;
		
		double lhs = 0;
		double rhs = 0;
		
		if (newCount == 0)
		{
			accept = true;
			lhs = -1;
			rhs = -1;
		}
		else
		{
			double rand = _random.nextDouble();
			lhs = Math.log(rand);
			rhs = Math.log((double)oldCount/newCount);
			rhs -= hastings;
			rhs -= newll;
			rhs += _savedLoglikelihood;
			accept =  lhs < rhs;
			

		}
		
		if (accept)
		{
			_monkeyHandler.accept();
			_savedLoglikelihood = newll;
			_savedResult = result;
		}
		else
		{
			_monkeyHandler.reject();
			_monkeyHandler.setActiveMonkeyNum(oldCount);
		}
	}
	

	public ChimpleResults chimplify(int burnin, int numSamples, int spacing) 
	{
		return chimplify(burnin,numSamples,spacing, new Object[]{});
	}

	public ChimpleResults chimplify(int burnin, int numSamples, int spacing, Object [] programArgs) 
	{
		return chimplify(burnin,numSamples,spacing,programArgs,null);
	}

	
	public ChimpleResults chimplify(int burnin, int numSamples, int spacing, Object [] programArgs,CostBase costFunction) 
	{

		if (costFunction != null)
			costFunction.setHandler(_monkeyHandler);
		
		startChimplify();
		ChimpleResults results = new ChimpleResults(numSamples);

		try
		{
			
			for (int i = 0; i < burnin; i++)
				runProgram(programArgs,costFunction);
	
			
			for (int i = 0; i < numSamples; i++)
			{
				runProgram(programArgs,costFunction);
				
				//store result
				results.getResults()[i] = _savedResult;
				
				//store likelihood
				results.getLogLikelihoods()[i] = _savedLoglikelihood;
				
				if (i != (numSamples-1))
				{
					for (int j = 0; j < spacing; j++)
					{
						runProgram(programArgs,costFunction);
					}
				}
				
			}
		}
		finally
		{
			endChimplify();
		}
		
		return results;
	}

	private void runProgram(Object [] args, CostBase costFunction) 
	{
		int oldCount = startRunProgram();

		Object result = run(args);
		
		if (costFunction  != null)
			addCost(costFunction.calculateCost(result));
		
		endRunProgram(oldCount,result);
		
	}
	
	public class ChimpleResults
	{
		private Object [] _results;
		private double [] _likelihoods;
		
		public ChimpleResults(int numSamples)
		{
			_results = new Object[numSamples];
			_likelihoods = new double[numSamples];
		}
		
		public Object [] getResults()
		{
			return _results;
		}
		
		public double [] getLogLikelihoods()
		{
			return _likelihoods;
		}
	}
}
