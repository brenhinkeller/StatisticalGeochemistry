function index=findclosest(source, target)
% index=findclosest(source, target)
% Return the index of the closest value of Target for each value in Source

source=source(:);
target=target(:);

index=zeros(size(source));
for i=1:length(source)
    [~, index(i)]=min((target-source(i)).^2);
end