function out=sigfigs(in,varargin)
if nargin==1
    maxfigs=8;
elseif nargin==2
    maxfigs=varargin{1};
elseif nargin>2
    error('Too many input arguments')
end

% Set default maximum number of sig figs to search for
out=ones(size(in))*maxfigs;
% NaN has NaN sig figs
out(isnan(in))=NaN;
% Find remaining sig figs
for i=fliplr(0:maxfigs-1)
    out(mod(in,10.^floor(log10(abs(in))-i+1))==0)=i;
end