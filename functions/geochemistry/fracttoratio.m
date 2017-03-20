function [dataout,varargout] = fracttoratio(data, error)

dataout=data./(1-data);

% Error if requested
if(nargin>1)
    varargout{1}=abs((data+error)./(1-(data+error)) - (data-error)./(1-(data-error)))/2;
end
