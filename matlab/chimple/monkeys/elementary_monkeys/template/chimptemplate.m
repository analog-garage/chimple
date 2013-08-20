function result = chimptemplate(name,param1,param2,param3)
      
    if nargin<4
        param3=0;
    end
    if nargin<3
        param2=0;
    end
    if nargin<2
        param1=0;
    end
    params=cell(3,1);
    params{1}=param1;
    params{2}=param2;
    params{3}=param3;

    result = runMonkey(@chimptemplate_gen,@chimptemplate_regen,@chimptemplate_likelihood,@chimptemplate_kernel,name,params);
    
end
