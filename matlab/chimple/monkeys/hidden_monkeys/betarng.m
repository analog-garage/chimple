function r = betarng(beta)

r=gammarng(beta,1,1);
r=r/(r+gammarng(1,1,1));
end
