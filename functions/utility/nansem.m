function out=nansem(data,varargin)
% Standard error of the mean, ignoring NaN rules

if nargin==1
    out=sqrt(nanvar(data))./sqrt(sum(~isnan(data)));
    
elseif nargin==2
    % Two input arguments: data and weights
    w=varargin{1}; % sample weights;
    out=sqrt(nanvar(data,w))./sqrt(sum(~isnan(data)));
    
elseif nargin==3
    % Three input arguments: data, weights, and dimension
    w=varargin{1}; % sample weights;
    dim=varargin{2};
    out=sqrt(nanvar(data,w,dim))./sqrt(sum(~isnan(data)));
    
else
    error('Error: Too many input arguments.')
    
end