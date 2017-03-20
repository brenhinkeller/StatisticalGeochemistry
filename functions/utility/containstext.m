function text=containstext(str, strcell)
% text=contains(str, strcell)
% Return the values of strcell that contain str

if ischar(str) && iscell(strcell)
    text = strcell(~cellfun(@isempty,strfind(lower(strcell),lower(str))));
elseif ischar(strcell) && iscell(str)
    % If input arguments are reversed, make it work anyways
    text = str(~cellfun(@isempty,strfind(lower(str),lower(strcell))));
else
    % Otherwise, error
    error('Requires one string and one cell array of strings.\n')
end


