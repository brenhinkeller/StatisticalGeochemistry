function index=contains(str, strcell)
% index=contains(str, strcell)
% Return the index for values of strcell that contain str

if ischar(str) && iscell(strcell)
    index = ~cellfun(@isempty, strcell);
    index(index) = ~cellfun(@isempty,strfind(lower(strcell(index)),lower(str)));
elseif ischar(strcell) && iscell(str)
    % If input arguments are reversed, make it work anyways
    index = ~cellfun(@isempty, str);
    index(index) = ~cellfun(@isempty,strfind(lower(str(index)),lower(strcell)));
else
    % Otherwise, error
    error('Requires one string and one cell array of strings.\n')
end

