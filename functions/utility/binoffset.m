function [bincenters,averages,errors]=binoffset(x,y,offset,min,max,oversamplingratio,nbins)
if nargin==7
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;
    
    averages=NaN(1,nbins);
    errors=NaN(1,nbins);

    for i=1:nbins
        t = (x>binedges(i)&x<(binedges(i+1)+offset));
        averages(i)=nanmean(y(t));
        errors(i)=nansem(y(t)).*sqrt(oversamplingratio);
    end
elseif nargin<7
    error('Too few input arguments.')
elseif nargin>7
    error('Too many input arguments.')
end
