function [bincenters,averages,errors]=binweighted(x,y,weight,min,max,oversamplingratio,nbins,varargin)
if nargin==7
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;
    
    
    averages=NaN(1,nbins);
    errors=NaN(1,nbins);
    
    for i=1:nbins
        t = x>binedges(i) & x<binedges(i+1);
        averages(i)=nanmean(y(t).*weight(t))./nanmean(weight(t));
%         averages(i)=nanmean(y(t));
        errors(i)=nansem(y(t)).*sqrt(oversamplingratio);
    end
    
    
elseif nargin==8
    binoverlap=varargin{1};
    
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);
    
    averages=NaN(1,nbins);
    errors=NaN(1,nbins);
    
    for i=1:nbins
        t = x>(bincenters(i)-binhalfwidth) & x<(bincenters(i)+binhalfwidth);
        averages(i)=nanmean(y(t).*weight(t))./nanmean(weight(t));
%         averages(i)=nanmean(y(t));
        errors(i)=nansem(y(t)).*sqrt(oversamplingratio);
    end  
elseif nargin<7
    error('Too few input arguments.')
elseif nargin>8
    error('Too many input arguments.')
end
