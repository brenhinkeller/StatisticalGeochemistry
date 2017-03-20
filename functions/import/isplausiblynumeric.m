function out=isplausiblynumeric(x)
out=false;
if isempty(x) || isnumeric(x)
    % If it's empty, it could be a NaN
    out=true;
elseif ischar(x)
    if strcmp(x,'NaN') || strcmp(x,'NAN') || strcmp(x,'NA')
        % If it's a NaN, we'll consider it plausibly numeric
        out=true;
%     elseif all(isstrprop(x,'digit') | isstrprop(x,'punct'))
    elseif all((x>39&x<47)|(x>47&x<58)|x=='e'|x=='E')
        % If it's a string of digits and punctuation, we'll consider it
        % plausibly numeric
        out=true;
    end
end
