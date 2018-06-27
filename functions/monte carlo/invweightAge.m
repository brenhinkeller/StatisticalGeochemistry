function out = invweightAge(age)
% Produce a weighting coefficient for each row of data corresponding 
% to the input age that is inversely proportional to the 
% temporal data concentration

% Check if there is and age data
nodata=isnan(age);

i=1;
k=zeros(length(age),1);
fprintf('\n')
while i<=length(age)
    if nodata(i)
        % If there is no data, set k=inf for weight=0
        k(i)=Inf;
    else
        % Otherwise, calculate weight
         k(i)=sum(1./((age(i)-age(~nodata)).^2+1));

    end
    % Display progress
    if mod(i,100)==0
        if i>100
            bspstr=repmat('\b',1,floor(log10(i-100))+1);
            fprintf(bspstr)
        end
        fprintf('%i',i)
    end
    % Increment i
    i=i+1;
end
fprintf('\n')
out=k;