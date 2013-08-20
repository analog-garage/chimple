function monkeyHandler = getMonkeyHandler()
    global gMonkeyHandler;
    
    if isempty(gMonkeyHandler)
       gMonkeyHandler = com.analog.lyric.chmpl.MatlabProxy();
    end
    monkeyHandler = gMonkeyHandler;
end
