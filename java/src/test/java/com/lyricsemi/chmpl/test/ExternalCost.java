package com.lyricsemi.chmpl.test;

import com.analog.lyric.chmpl.CostBase;
//import org.junit.Test;
import static org.junit.Assert.*;

public class ExternalCost extends CostBase 
{

	@Override
	public double calculateCost(Object... results) 
	{
		int a = (Integer)getValue("a");
		int b = (Integer)getValue("b");
		int c = (Integer)getValue("c");
		int d = (Integer)getValue("d");
	    
		assertTrue(c==a+b+1);
	    assertTrue(results[0].equals(c));
	    
		return Math.log(d);
	}

}
