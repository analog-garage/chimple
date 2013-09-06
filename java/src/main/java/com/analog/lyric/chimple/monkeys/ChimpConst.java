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

public class ChimpConst extends MonkeyBase
{

	public ChimpConst(MonkeyHandler handler) 
	{
		super(handler);
	}

	@Override
	public Object generate(Object[] parameters)  
	{
		if (parameters.length != 1)
			throw new ChimpleException("expected one argument");
		return parameters[0];
	}

	@Override
	public double calculateLogLikelihood(Object result, Object[] parameters) 
	{
		return 0;
	}

	@Override
	public RegeneratorPair regenerate(Object oldVal, Object[] parameters)  
	{
		if (parameters.length != 1)
			throw new ChimpleException("expected one argument");
		
		return new RegeneratorPair(parameters[0],0);
	}
	
	@Override
	protected boolean paramatersAreSame(Object [] params1, Object [] params2)
	{
		return false;
	}


}
