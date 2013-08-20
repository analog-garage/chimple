package com.lyricsemi.chmpl.test;

import com.analog.lyric.chmpl.ChmplProgram;

/*
 * This is an exmaple of a chimple program.  The BiasTest
 * actually instantiates this and calls chimplify.
 */
public class MyBiasProgram extends ChmplProgram 
{

	@Override
	public Object run(Object ... args)  
	{
		int S = chimpFlip("S");

		if (S == 1)
		{
			chimpRand("X2");
			chimpRand("X3");
			chimpRand("X4");
			chimpRand("X5");
		}
		
		addCost(-Math.log(1));
		
		return S;
	}

}
