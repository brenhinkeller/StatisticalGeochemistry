function [dataout errorout] = fracttoratio(data, error)

dataout=data./(1-data);

errorout=abs((data+error)./(1-(data+error)) - (data-error)./(1-(data-error)))/2;

% Discarded routines:
% c=nancov(data, 1-data);
% errorout=data.*sqrt(error.^2./(1-data).^2 + error.^2./data.^2 - 2*c(1,2)./(data)./(1-data));
% errorout=sqrt(error.^2./(1-data).^2 + error.^2.*(-data./(1-data).^2).^2);
% errorout=sqrt(error.^2./(1-data).^2 + error.^2.*(-data./(1-data).^2).^2 + c(1,2).*(-data./(1-data).^3));

