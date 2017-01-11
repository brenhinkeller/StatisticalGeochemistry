function [bincenters,averages,errors]=bin(x,y,min,max,oversamplingratio,nbins,varargin)
if nargin==6
    binoverlap = 0;
elseif nargin==7 
    binoverlap=varargin{1}; 
elseif nargin<6
    error('Too few input arguments.')
elseif nargin>7
    error('Too many input arguments.')
end

averages=NaN(1,nbins);
errors=NaN(1,nbins);

if binoverlap>1
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);

    for i=1:nbins
        averages(i)=nanmean(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth));
        errors(i)=nansem(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth)).*sqrt(oversamplingratio);
    end 
else
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;

    for i=1:nbins
        averages(i)=nanmean(y(x>binedges(i)&x<binedges(i+1)));
        errors(i)=nansem(y(x>binedges(i)&x<binedges(i+1))).*sqrt(oversamplingratio);
    end
end