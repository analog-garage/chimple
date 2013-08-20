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