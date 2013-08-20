function [random]=setunirng(set)

dims=size(set);
numel=prod(dims);
randel=floor(numel*rand())+1;
sset=reshape(set,1,numel);
random=sset(randel);
