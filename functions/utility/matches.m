function index=matches(source, target)
% index=findmatches(source, target)
% Find the indices of each value in Target that matches any value in Source

% Linearize array
source=source(:);
target=target(:);

% Allocate output varible
index=false(size(target));

if isnumeric(source) && isnumeric(target)
    % If it's a numeric array, search for exact equality
    for i=1:length(source)
        index=index|source(i) == target;
    end
elseif iscell(source) && iscell(target)
    % If it's a numeric array, check for equality with a cellfun
    for i=1:length(source)
        index=index|cellfun(@(x) all(size(source{i}) == size(x)) && all(source{i} == x), target);
    end
else
    error('matches() requires cell or numeric input')
end