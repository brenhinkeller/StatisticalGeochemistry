function [bincenters,averages,errors]=binweighted(x,y,weight,min,max,oversamplingratio,nbins,varargin)
if nargin==7
    binoverlap=0;
elseif nargin==8
    binoverlap=varargin{1};
elseif nargin<7
    error('Too few input arguments.')
elseif nargin>8
    error('Too many input arguments.')
end

averages=NaN(1,nbins);
errors=NaN(1,nbins);

if binoverlap>1;  
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);
    
    for i=1:nbins
        t = x>(bincenters(i)-binhalfwidth) & x<(bincenters(i)+binhalfwidth);
        averages(i)=nanmean(y(t).*weight(t))./nanmean(weight(t));
        errors(i)=nansem(y(t)).*sqrt(oversamplingratio);
    end  
    
else
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;
    
    for i=1:nbins
        t = x>binedges(i) & x<binedges(i+1);
        averages(i)=nanmean(y(t).*weight(t))./nanmean(weight(t));
        errors(i)=nansem(y(t)).*sqrt(oversamplingratio);
    end
end