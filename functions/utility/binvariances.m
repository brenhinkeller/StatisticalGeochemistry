function [bincenters,variances]=binvariances(x,y,min,max,nbins,varargin)
% [bincenters,averages,errors,varargout]=bin(x,y,min,max,oversamplingratio,nbins,varargin)
% Return the average values for independent variable y binned as a funciton 
% of independent variable x.

if nargin==5
    binoverlap = 0;
elseif nargin==6
    binoverlap=varargin{1}; 
elseif nargin<5
    error('Too few input arguments.')
elseif nargin>6
    error('Too many input arguments.')
end

variances=NaN(1,nbins);

if binoverlap>1
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);

    for i=1:nbins
        variances(i)=nanvar(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth));
    end 

else
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;

    for i=1:nbins
        variances(i)=nanvar(y(x>binedges(i)&x<binedges(i+1)));
    end
end