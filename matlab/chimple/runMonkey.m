function result = runMonkey(generator,regenerator,likelihoodcalculator,name,parameters)
            

proxy = getMonkeyHandler();
monkeyHandler = proxy.getMonkeyHandler();

if nargin < 5
    parameters = {0};
end

monkeyHandler.plusplus();

if ~monkeyHandler.getMHMode()
    result = generator(parameters{:});
else

    runNumber = monkeyHandler.getRunNumber();
    
    monkey = monkeyHandler.getMonkeyByName(name);

    
    if ~isempty(monkey)
        

        if monkey.getLastTouched() == runNumber
            error('Variable (%s) already created',name);
        end
        
        if monkey.getIsChosenOne()
            oldVal=monkey.getValue;
            oldLikelihood=monkey.getLikelihood();
            [result,hastings]= regenerator(oldVal,parameters{:});
            likelihood = likelihoodcalculator(result,parameters{:});
            monkey.setValueAndLikelihood(result,likelihood,runNumber);
            monkeyHandler.setHastings(likelihood-oldLikelihood+hastings);
        else
            if isequal(cell(monkey.getParameters),parameters)
            
                result = monkey.getValue();
                likelihood = likelihoodcalculator(result,parameters{:});
                monkey.setLikelihood(likelihood,runNumber);
                
            else
                result = generator(parameters{:});
                likelihood = likelihoodcalculator(result,parameters{:});
                monkey.setValueAndLikelihood(result,likelihood,runNumber);
                monkey.setParameters(parameters);
            end

        end
   
        
    else
        result = generator(parameters{:});
        likelihood = likelihoodcalculator(result,parameters{:});
        monkeyHandler.addMonkey(name,result,likelihood,runNumber,parameters);

    end

 

    %hash = java.util.HashMap();
    %hash.put(2,3);
    %s = com.analog.lyric.Stuff();
    %s.nextGaussian();
    %result = 0;
end
