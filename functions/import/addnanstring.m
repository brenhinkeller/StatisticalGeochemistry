function x=addnanstring(x)
if isempty(x) % NaN-out empty cells
    x='NaN';
end
if ~ischar(x) % NaN-out non-strings
    x='NaN';
else
    x=regexprep(x,'[^-0-9.eE]',''); % Remove any characters that aren't digits or a decimal point
    if ~any(isstrprop(x,'digit')) % NaN-out strings without at least one digit
        x='NaN';
    elseif length(strfind(x,'.')) > 1 % NaN-out strings with multiple decimal places
        x='NaN';
    end
end
end

% Old version
%~all(isstrprop(x,'digit') | isstrprop(x,'punct'))