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

package com.analog.lyric.chimple.demos;

import com.analog.lyric.chimple.ChimpleProgram;
import com.analog.lyric.chimple.CostBase;

public class RandomCoin 
{	
	public static class RandomCoinProgram extends ChimpleProgram
	{

		@Override
		public Object run(Object... args) 
		{

			//Generates a random weight for a coin
			double weight = chimpRand("weight");
			int sumout = 0;
			int [] flips = new int[20];
			for (int i = 0; i < 20; i++)
			{
				flips[i] = chimpFlip("X" + i,weight);
				sumout += flips[i];
			}

			chimpConst("sumvar",sumout);
			chimpConst("sum_observed",args[0]);
    
    		return weight;
		}
	
	}
	

	public static class CostFunction extends CostBase
	{

		@Override
		public double calculateCost(Object result) 
		{
			int sum_observed = (Integer)getValue("sum_observed");
			int sum_var = (Integer)getValue("sumvar");

			return Math.exp(Math.abs(sum_observed-sum_var));
		}			
	}
	
	public static double run(boolean verbose)
	{

		int burnin = 100;
		int samples = 100;
		int spacing = 5;
		int sum_val = 15;
		RandomCoinProgram program = new RandomCoinProgram();
		program.setSeed(0);
		Object [] results = program.chimplify(burnin,samples,spacing,new Object [] {sum_val},new CostFunction()).getResults();

		double average = 0;
		
		for (int i = 0; i < results.length; i++)
		{
			double result = (Double)results[i];
			average += result;
		}
		
		average /= results.length;
		
		if (verbose)
			System.out.println(average);
		
		return average;
	}
	
	public static void main(String [] args)
	{
		run(true);
	}
}
