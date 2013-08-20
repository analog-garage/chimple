package com.lyricsemi.chmpl.test;


import org.junit.Test;

import com.analog.lyric.chmpl.ChmplProgram.ChmplResults;

import static org.junit.Assert.*;

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
		ChmplResults results = m.chimplify(burnin, samples, spacing);
		
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
		ChmplResults results = program.chimplify(burnin,spacing,samples,new Object [] {},new ExternalCost());
		
		for (int i = 0; i < results.getLikelihoods().length; i++)
			assertTrue(results.getLikelihoods()[i] == Math.log(10));

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
			ChmplResults results = m.chimplify(burnin, samples, spacing);
			
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
