function [m]=standardize(m,varargin)
mu=nanmean(m,varargin{:});
sigma=nanstd(m,0,varargin{:});

if length(mu) == 1;
    m = (m - mu)./sigma;
else
    m=(m-repmat(mu,size(m)./size(mu)))./repmat(sigma,size(m)./size(sigma));
end