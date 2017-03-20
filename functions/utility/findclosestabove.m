function index=findclosestabove(source, target)
% index=findclosestabove(source, target)
% Return the index of the closest value of the vector 'target' above each 
% value in 'source'

source=source(:);
target=target(:);

index=zeros(size(source));
for i=1:length(source)
    t = find(target>source(i));
    [~, ti]=min((target(t)-source(i)).^2);
    index(i) = t(ti);
end