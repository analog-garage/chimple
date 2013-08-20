function [out]=discreterng(probs)

probs=cumsum(probs/sum(probs));

out=1;
U=rand();
while U>probs(out)
    out=out+1;
end
