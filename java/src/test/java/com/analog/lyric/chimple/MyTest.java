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


import static org.junit.Assert.*;

import org.junit.Test;

import com.analog.lyric.chimple.ChimpleProgram.ChimpleResults;
import com.analog.lyric.chimple.demos.MedicalBayesNet;
import com.analog.lyric.chimple.demos.RandomCoin;

public class MyTest
{
	
	/*
	 * The bias test should create almost equal numbers of 1s and 0s if the hastings term
	 * calculation is correct.
	 */
	@Test
	public void test_bias()
	{
		
		int burnin = 1000;
		int samples = 1000;
		int spacing = 100;
		
		MyBiasProgram m = new MyBiasProgram();
		
		//m.run();
		ChimpleResults results = m.chimplify(burnin, samples, spacing);
		
		int num0s = 0;
		int num1s = 0;
		
		for (int i = 0; i < results.getResults().length; i++)
		{
			int val = (Integer)results.getResults()[i];
			if (val  == 1)
				num1s++;
			else
				num0s++;
		}
		
		System.out.println("num1s: " + num1s + " num0s: " + num0s);
		assertTrue(num0s > 400);
		assertTrue(num1s > 400);
	}
	
	@Test
	public void test_externalCost()
	{

		int burnin = 100;
		int spacing = 10;
		int samples = 10;


		ExternalCostProgram program = new ExternalCostProgram();
		ChimpleResults results = program.chimplify(burnin,spacing,samples,new Object [] {},new ExternalCost());
		
		for (int i = 0; i < results.getLogLikelihoods().length; i++)
			assertTrue(results.getLogLikelihoods()[i] == Math.log(10));

	}
	
	@Test
	public void test_RandomCoin()
	{
		assertTrue(RandomCoin.run(false) > 0.75);
	}
	
	@Test
	public void test_MedicalBayesNet()
	{
		Object [] results = MedicalBayesNet.run(false);
		
		for (int i = 0; i < results.length; i++)
		{
			Object [] result = (Object[])results[i];
			
			int cancer = (Integer)result[0];
			int cold = (Integer)result[1];
			int cough = (Integer)result[2];
			
			assertTrue(cancer+cold+cough >= 2);
		}
	}
	
	@Test
	public void test_seed()
	{
		int burnin = 100;
		int samples = 100;
		int spacing = 100;
		
		MyBiasProgram m = new MyBiasProgram();
		
		int firstNum0s = 0;
		int firstNum1s = 0;
		
		
		for (int i = 0; i < 10; i++)
		{
			
			m.setSeed(0);
			//m.run();
			ChimpleResults results = m.chimplify(burnin, samples, spacing);
			
			int num0s = 0;
			int num1s = 0;
			
			for (int j = 0; j < results.getResults().length; j++)
			{
				int val = (Integer)results.getResults()[j];
				if (val  == 1)
					num1s++;
				else
					num0s++;
			}
			
			if (i == 0)
			{
				firstNum0s = num0s;
				firstNum1s = num1s;
			}
			else
			{
				assertTrue(num0s == firstNum0s);
				assertTrue(num1s == firstNum1s);
			}
			
		}

	}
	
}
