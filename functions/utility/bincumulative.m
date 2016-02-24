function [bincenters,averages,errors]=bincumulative(x,y,min,max,oversamplingratio,nbins,varargin)
binwidth=(max-min)/nbins;
binedges=linspace(min,max,nbins+1);
bincenters=min+binwidth/2:binwidth:max-binwidth/2;

averages=NaN(1,nbins);
errors=NaN(1,nbins);

if nargin==6
    for i=1:nbins
        averages(i)=nanmean(y(x>binedges(i)&x<binedges(end)));
        errors(i)=nansem(y(x>binedges(i)&x<binedges(end))).*sqrt(oversamplingratio);
    end
elseif nargin==7
    xmax=varargin{1}; % Varargin gives global maximum x value
    for i=1:nbins
        averages(i)=nanmean(y(x>binedges(i)&x<xmax));
        errors(i)=nansem(y(x>binedges(i)&x<xmax)).*sqrt(oversamplingratio);
    end
else 
    error('[bincenters,averages,errors]=bincumulative(x,y,min,max,oversamplingratio,nbins,varargin)')
end
    
end