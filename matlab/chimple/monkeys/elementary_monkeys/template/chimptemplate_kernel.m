function [newval,hastings]= chimpdirichlet_kernel(oldvalue,param1,param2,param3)
%must take all parameters as input
% some arbitrary scheme to give x' as a function of x. doesn't have to be
% symmetric
% also returns the Hastings term, defined as 
% -log(q(newVal->oldVal)/q(oldVal->newVal)
    result =  oldvalue+0;
    hastings=0;
end
