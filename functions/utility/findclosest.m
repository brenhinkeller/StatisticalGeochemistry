function index=findclosest(source, target)
% index=findclosest(source, target)
% Return the index of the closest value of Target for each value in Source

% Linearize arrays
source=source(:);
target=target(:);

% Allocate output varible
index=zeros(size(source));

if isnumeric(source) && isnumeric(target)
    for i=1:length(source)
        [~, index(i)]=min((target-source(i)).^2);
    end
else
    error('findclosest() requires cell or numeric input')
end