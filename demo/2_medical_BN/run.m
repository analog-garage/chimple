
global CHIMPLE_TEST_DEMOS_RUNNING
if isempty(CHIMPLE_TEST_DEMOS_RUNNING)
    CHIMPLE_TEST_DEMOS_RUNNING = false;
end

burnin = 10; 
samples = 100; 
spacing = 10;
% did we observe cough?
cough_value=1;
results = chimplify(@medical_BN,...
    burnin , samples , spacing ,{cough_value} , @costfunction);

totals = zeros(length(results),3);
for i = 1:length(results)
   for j = 1:3
       totals(i,j) = results{i}{j};
   end
end

if ~ CHIMPLE_TEST_DEMOS_RUNNING
    disp(sum(totals));
end