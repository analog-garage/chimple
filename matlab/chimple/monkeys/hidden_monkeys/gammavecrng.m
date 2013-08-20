function [out]=gammarnd(alphas,betas)

out=zeros(size(alphas));
for i=1:numel(alphas)
    out(i)=mygamrnd(alphas(i),betas(i));
end
