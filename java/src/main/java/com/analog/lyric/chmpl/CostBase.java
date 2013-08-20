package com.analog.lyric.chmpl;

public abstract class CostBase 
{
	private MonkeyHandler _handler;
	
	public void setHandler(MonkeyHandler handler)
	{
		_handler = handler;
	}
	
	public Object getValue(String name)
	{
		//TODO: do I need to check that it's an active monkey?
		
		return _handler.getMonkeyByName(name).getValue();
	}

	
	public abstract double calculateCost(Object ... results);
}
