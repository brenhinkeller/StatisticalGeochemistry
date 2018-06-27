function y = nanmsem(x,varargin)
% Estimated standard error of the mean, based on median absolute
% deviation to increase outlier robustness (ignoring NANs)
m = nanmedian(x,varargin{:});
l = sum(~isnan(x),varargin{:});
s = nanmedian(abs(x - repmat(m,size(x)./size(m))),varargin{:}); % * 1.4826 % Factor of 1.4826 converts from median absolute deviation to standard deviation for Normal data
y = s ./ repmat(sqrt(l),size(s)./size(l)); 