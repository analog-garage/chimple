function [out]=vectorindex(input_vector)

current_value=0;

n=length(input_vector);

begin_index=1;
end_index=n;
current_index=floor((begin_index+end_index)/2);

while end_index>begin_index+1
    
    val=input_vector(current_index);
    if val>n-current_index+1
        end_index=current_index;
    else
        begin_index=current_index;
    end
    current_index=floor((begin_index+end_index)/2);

end

out=input_vector(current_index);
