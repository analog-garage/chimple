package com.analog.lyric.chmpl;

import java.util.ArrayList;
import java.util.HashMap;

import com.analog.lyric.math.RandomPlus;

/*
 * There is only one MonkeyHandler per ChmplProgram.  This class is responsible for maintaining
 * a list of all MonkeyOutput, the current list of costs, and provides some methods for saving and
 * reverting MonkeyOutput.
 */
public class MonkeyHandler 
{
	
	private double _hastings;
	private int _activeMonkeyNum;
	private boolean _mhMode;
	private ArrayList<Double> _costs;
	private int _runNumber;
	private ArrayList<MonkeyOutput> _allMonkeys;
	private RandomPlus _random;
	private HashMap<String,MonkeyOutput> _name2monkey;
	
	public MonkeyHandler(RandomPlus random)
	{
		_random = random;
		init();
	
	}
	
	public RandomPlus getRandom()
	{
		return _random;
	}
	
	public void init()
	{
		_hastings = 0;
		_activeMonkeyNum = 1;
		_mhMode = false;
		_costs = new ArrayList<Double>();
		_runNumber = 0;
		_allMonkeys = new ArrayList<MonkeyOutput>();
		_name2monkey = new HashMap<String, MonkeyOutput>();
	}
	
	public void plusplus()
	{
		_activeMonkeyNum++;
	}
	
	public int getRunNumber()
	{
		return _runNumber;
	}
	
	public MonkeyOutput getMonkeyByName(String name)
	{
		return _name2monkey.get(name);
	}
	
	public void setMHMode(boolean doMH)
	{
		_mhMode = doMH;
	}
	
	public boolean getMHMode()
	{
		return _mhMode;
	}
	
	public void prepareForRun()
	{
		_costs.clear();
		
		
		_runNumber++;
        
		                    
        if (_allMonkeys.size() > 0)
        {
            
            //Decide which Monkey to regenerate
        	int whichToRemove = Math.abs(_random.nextInt())%_allMonkeys.size(); 
            //System.out.println("which to remove: " + whichToRemove);
        	_allMonkeys.get(whichToRemove).setIsChosenOne(true);
            
        }
	}
	public int getActiveMonkeyNum()
	{
		return _activeMonkeyNum;
	}
	public void resetNum()
	{
		_activeMonkeyNum = 0;
	}

	public ArrayList<Double> getCosts()
	{
		return _costs;
	}
	
	public void setHastings(double value)
	{
		_hastings = value;
	}
	
	public double getHastings()
	{
		return _hastings;
	}
	
	public void accept()
	{
		ArrayList<MonkeyOutput> newMonkeyList = new ArrayList<MonkeyOutput>();
		
		for (int i = 0; i < _allMonkeys.size(); i++)
		{
			MonkeyOutput monkey = _allMonkeys.get(i);

			if (monkey.getLastTouched() != _runNumber)
			{
				_name2monkey.remove(monkey.getName());
			}
			else
			{
				monkey.setIsChosenOne(false);
				newMonkeyList.add(monkey);
			}
			
		}

		_allMonkeys = newMonkeyList;

		
	}
	public void reject()
	{
		ArrayList<MonkeyOutput> newMonkeyList = new ArrayList<MonkeyOutput>();
        
		for (int i =  0; i < _allMonkeys.size(); i++)
		{
		
			MonkeyOutput monkey = _allMonkeys.get(i);
            
            if (monkey.getWhenCreated() == _runNumber)
                _name2monkey.remove(monkey.getName());
            else
            {
                newMonkeyList.add(monkey);
                if (monkey.getIsChosenOne())
                	monkey.revertToSaved();
            }
            
		}
        _allMonkeys = newMonkeyList;
	}
	
	public void setActiveMonkeyNum(int num)
	{
		_activeMonkeyNum = num;
	}

	public void addCost(double cost)
	{
		_costs.add(cost);
	}
	
	public void addMonkey(String name, Object result, double likelihood,int runNumber, Object [] parameters) 
	{
		MonkeyOutput monkey = new MonkeyOutput(name, result, likelihood, runNumber, parameters);
		if (_name2monkey.containsKey(name))
			throw new ChimpleException("ack");
		_name2monkey.put(name,monkey);
		_allMonkeys.add(monkey);
	}

}
