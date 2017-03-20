function y = nanmad(x,varargin)
% Median absolute deviation, ignoring NANs
m = nanmedian(x,varargin{:});
y = nanmedian(abs(x - repmat(m,size(x)./size(m))),varargin{:});