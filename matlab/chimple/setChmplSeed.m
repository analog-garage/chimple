function setChmplSeed(seed)
    getMonkeyHandler().setSeed(seed);
    rand('seed',seed);
    randn('seed',seed);
end
