function y = unitmean(x,varargin)
% Divide a variable by its mean, to set mu=1 (for positive data)
m=nanmean(x,varargin{:});
if length(m)==1;
    y=x./m;
else
    y=x./repmat(m,size(x)./size(m));
end