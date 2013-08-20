function value = getChimpValue( name )
    handler = getMonkeyHandler();
    value = handler.getValue(name);
end

