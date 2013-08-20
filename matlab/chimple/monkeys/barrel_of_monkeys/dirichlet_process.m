function [sampled_set,probabilities]=dirichlet_process(name,func,concentration,funcparams,supK,tolerance)


if nargin<3
    concentration=1;
end
if nargin<4
    funcparams={};
end
if nargin<6
    tolerance=0.001;
end
if nargin<5
    supK=max(1,ceil(log(1/concentration*log(1/(1-tolerance)))/log(concentration/(1+concentration))));
end

pis=zeros(1,supK);
betas=zeros(1,supK);
sampled_set=cell(1,supK);

betas(1)=chimpbeta(sprintf('%s%s%d',name,'beta',1),1,concentration);
pis(1) = betas(1);
for i=2:supK
    betas(i)=chimpbeta(sprintf('%s%s%d',name,'beta',i),1,concentration);
    pis(i)=betas(i)*(1-betas(i-1))/betas(i-1)*pis(i-1);
end

for i=1:supK
   sampled_set{i}=func(sprintf('%s%s%d',name,'sset',i),funcparams{:});
end
probabilities=pis;
