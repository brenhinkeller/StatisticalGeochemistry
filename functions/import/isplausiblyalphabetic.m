function out=isplausiblyalphabetic(x)
out=false;
if isempty(x) || isnumeric(x)
    % If it's empty, it could be anything
    out=true;
elseif ischar(x)
    if any(isstrprop(x,'graphic')&~((x>39&x<47)|(x>47&x<58)|x=='e'|x=='E')) %any(isstrprop(x,'alpha'))
        % If it contains any alphabetic characters, could be a string
        out=true;
    end
end