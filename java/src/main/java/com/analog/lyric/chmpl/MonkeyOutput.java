package com.analog.lyric.chmpl;

/*
 * MonkeyOutput instances represent the results of calls to elementary random monkeys. 
 * For instance, every call to chimpFlip results in a MonkeyOutput instance.  This class
 * contains version numbers, values, saved values, and log likelihoods.
 */
public class MonkeyOutput 
{

	private int _lastTouched;
	private int _whenCreated;
	private boolean _isChosenOne;
	private String _name;
	private Object _value;
	private double _loglikelihood;
	private double _savedloglikelihood;
	private Object [] _parameters;
	private Object _savedValue;
	
	public MonkeyOutput(String name,Object value, double loglikelihood,int whenCreated, Object [] params)
	{
			_name = name;
			_value = value;
			_loglikelihood = loglikelihood;
			_savedloglikelihood= loglikelihood;
			_whenCreated = whenCreated;
			_parameters = params;
			_isChosenOne = false;
			_lastTouched = _whenCreated;
			_savedValue = value;
	}
	
	public Object getValue()
	{
		return _value;
	}
	public double getLikelihood()
	{
		return _loglikelihood;
	}
	public void setIsChosenOne(boolean ischosen)
	{
		_isChosenOne = ischosen;
		_savedloglikelihood=_loglikelihood;
	}
	
	public int getLastTouched()
	{
		return _lastTouched;
	}
	
	public String getName()
	{
		return _name;
	}
	
	public int getWhenCreated()
	{
		return _whenCreated;
	}
	
	public boolean getIsChosenOne()
	{
		return _isChosenOne;
	}
	public void revertToSaved()
	{
		_value = _savedValue;
		_isChosenOne = false;
		_loglikelihood=_savedloglikelihood;
	}

	public void saveValue()
	{
		_savedValue = _value;
	}
	
	public void setValueAndLikelihood(Object result, double likelihood,
			int runNumber) 
	{
        saveValue();
        _value = result;
        _loglikelihood = likelihood;
        _lastTouched = runNumber;
	}
	
	public Object [] getParameters()
	{
		return _parameters;
	}

	public void setLikelihood(double likelihood,int runNumber)
	{
		_loglikelihood = likelihood;
		_lastTouched = runNumber;
	}
	
	public void setParameters(Object [] params)
	{
		_parameters = params;
	}

}
