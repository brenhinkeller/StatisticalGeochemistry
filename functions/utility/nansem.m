function out=nansem(data,varargin)
% Standard error of the mean, ignoring NaN rules

out=nanstd(data,0,varargin{:})./sqrt(sum(~isnan(data),varargin{:}));
end