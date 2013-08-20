package com.analog.lyric.chmpl;


/*
 * The MatlabProxy class is used by the MATLAB Chmpl.  It is a thin wrapper around
 * ChmplProgram, simply making it a concrete class.
 */
public class MatlabProxy extends ChmplProgram 
{
	@Override
	public Object run(Object ... args)  
	{
		throw new ChimpleException("ack");
	}
}
