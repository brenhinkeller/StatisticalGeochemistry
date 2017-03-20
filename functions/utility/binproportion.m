function [bincenters,proportions]=binproportion(x,a,b,min,max,nbins,varargin)
% [bincenters,averages,errors,varargout]=bin(x,y,min,max,nbins,[binoverlap])
% Return the average proportion of a to b binned as a funciton 
% of independent variable x.

if nargin==6
    binoverlap = 0;
elseif nargin==7 
    binoverlap=varargin{1}; 
elseif nargin<6
    error('Too few input arguments.')
elseif nargin>7
    error('Too many input arguments.')
end

proportions=NaN(1,nbins);

if binoverlap>1
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);

    for i=1:nbins
        na = nansum(a(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth));
        nb = nansum(b(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth));
        proportions(i)=na/(na+nb);
    end 

else
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;

    for i=1:nbins
        na=nansum(a(x>binedges(i)&x<binedges(i+1)));
        nb=nansum(b(x>binedges(i)&x<binedges(i+1)));
        proportions(i)=na/(na+nb);
    end
end