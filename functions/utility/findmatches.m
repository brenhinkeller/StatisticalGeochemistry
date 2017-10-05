function index=findmatches(source, target)
% index=findmatches(source, target)
% Find the index of a value in Target (if any) that matches a value in Source
% for each value in Source

% Linearize arrays
source=source(:);
target=target(:);

% Allocate output varible
index=NaN(size(source));

if isnumeric(source) && isnumeric(target)
    % If it's a numeric array, search for exact equality
    for i=1:length(source)
        t = source(i) == target;
        if any(t)
            index(i) = find(t,1);
        end
    end
elseif iscell(source) && iscell(target)
    % If it's a numeric array, check for equality with a cellfun
    for i=1:length(source)
        t=cellfun(@(x) all(size(source{i}) == size(x)) && all(source{i} == x), target);
        if any(t)
            index(i) = find(t,1);
        end
    end
else
    error('findmatches() requires cell or numeric input')
end