function [bincenters,averages,errors]=bincumulativeopen(x,y,min,max,oversamplingratio,nbins)
binwidth=(max-min)/nbins;
binedges=linspace(min,max,nbins+1);
bincenters=min+binwidth/2:binwidth:max-binwidth/2;

averages=NaN(1,nbins);
errors=NaN(1,nbins);

if nargin==6
    for i=1:nbins
        averages(i)=nanmean(y(x>binedges(i)));
        errors(i)=nansem(y(x>binedges(i))).*sqrt(oversamplingratio);
    end
else
    error('[bincenters,averages,errors]=bincumulative(x,y,min,max,oversamplingratio,nbins)')
end
    
end