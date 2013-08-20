function result = biasprogram()


    S=chimpflip('S');
    if S
       X=1;
       X2=chimprand('X2');
       X3=chimprand('X3');
       X4=chimprand('X4');
       X5=chimprand('X5');
    else
       X=1;
    end

    addChimpCost(-log(double((X==1))));

    result = S;

end
