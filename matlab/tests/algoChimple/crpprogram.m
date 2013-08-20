function result = crpprogram()

    X=chimpbeta('X',1,1);
    Y=chimpdirichlet('Y',[3;3]);
    V=chimpdiscrete('V',Y);
    K=chimpflip('K',X);
    Z=K+V;
    addChimpCost(abs(1000*(Z-1)));
    result={X;Y;V;K;Z};


end
