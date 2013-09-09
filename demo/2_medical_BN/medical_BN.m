function [retval]=medical_BN(cough_value)
    %defines the probability of lung cancer to be 1%
    lung_cancer = chimpflip('LG' ,0.01);
    %defines the probability of cold cancer to be 20%
    cold=chimpflip ('cold',0.2);
    %cough is present if cold or lung cancer is present
    cough=or(cold, lung_cancer);
    chimpconst ('cough',cough);
    retval = {lung_cancer,cough_value,cold};
end