function [out]=flip(weight)

if rand()<weight
    out=1;
else
    out=0;
end
