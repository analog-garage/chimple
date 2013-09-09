function [out]=costfunction(lg_cancer,coughvalue,cold)

% first argument is required because it is the output
%of medical BN.m % second argument lets the user choose 
%the actual value cough as a parameter
if getChimpValue('cough') == coughvalue
    out = 0;
else
    out = 100;
end
%addHardChimpConstraint(getChimpValue('cough') ,coughvalue);