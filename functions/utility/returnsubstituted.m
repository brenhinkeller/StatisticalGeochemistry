function target=returnsubstituted(value,target,index)
% target=returnsubstituted(value,target,index)
% return Target with all values indicated by Index substituted with Value
if length(value)>1
    error('Multiple values suggested')
elseif length(value)<1
    error('Attempted to fill nonexistent value')
else
    target(index) = value;
end