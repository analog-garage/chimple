function testExternalCost

burnin = 100;
spacing = 10;
samples = 10;


%run chimplify by passing program and constraint
[results,costs] = chimplify(@externalCostProgram,burnin,spacing,samples,{},@externalCost);

for i = 1:samples
   assertTrue(costs(i) == log(10)); 
end

