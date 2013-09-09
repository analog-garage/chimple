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

public class MedicalBayesNet 
{
	public static class MyProgram extends ChimpleProgram
	{
		@Override
		public Object run(Object... args) 
		{
		    //defines the probability of lung cancer to be 1%
		    int lung_cancer = chimpFlip("LG" ,0.01);
		    //defines the probability of cold cancer to be 20%
		    int cold = chimpFlip ("cold",0.2);
		    //cough is present if cold or lung cancer is present
		    int cough = cold | lung_cancer;
		    
		    chimpConst ("cough",cough);
		    chimpConst("coughObserved",args[0]);

		    Object [] retval = new Object []{lung_cancer,cold,cough};
		    return retval;
		}
	}
	
	public static class MyCost extends CostBase
	{

		@Override
		public double calculateCost(Object results) {
			int cough = (Integer)getValue("cough");
			int coughObserved = (Integer)getValue("coughObserved");
			return cough == coughObserved ? 0 : 200;
		}
		
	}
	
	public static Object [] run(boolean verbose)
	{
		int burnin = 100;
		int samples = 100;
		int spacing = 10;
		MyProgram program = new MyProgram();
		Object [] input = new Object[] {(Integer)1};
		
		Object [] results = program.chimplify(burnin, samples, spacing,input,new MyCost()).getResults();
		
		int numLC = 0;
		int numCough = 0;
		int numCold = 0;
		
		for (int i = 0; i < results.length; i++)
		{
			Object [] tmp = (Object[])results[i];
			int lc = (Integer)tmp[0];
			int cold = (Integer)tmp[1];
			int cough = (Integer)tmp[2];
			
			if (verbose)
				System.out.println("Cancer: " + lc + " Cold: " + cold + " Cough: " + cough);
			
			numLC += lc;
			numCough += cough;
			numCold += cold;
		}
		
		if (verbose)
			System.out.println("LC: " + numLC + " cough: " + numCough + " cold: " + numCold);
		
		return results;
	}
	
	public static void main(String [] args)
	{
		run(true);
	}
}
