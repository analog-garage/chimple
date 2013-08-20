package com.lyricsemi.chmpl.test;

import com.analog.lyric.chmpl.ChmplProgram;

public class ExternalCostProgram extends ChmplProgram 
{

	@Override
	public Object run(Object ... args)  
	{
		int a = chimpFlip("a");
		int b = chimpFlip("b");
		Object value = chimpConst("c", a+b+1);
		chimpConst("d",10);
		
		return value;
	}

}
