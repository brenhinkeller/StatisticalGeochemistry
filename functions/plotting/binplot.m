function binplot(x,y,min,max,oversamplingratio,nbins,varargin)

binwidth=(max-min)/nbins;
binedges=linspace(min,max,nbins+1);
bincenters=min+binwidth/2:binwidth:max-binwidth/2;

averages=NaN(1,nbins);
errors=NaN(1,nbins);

for i=1:nbins
    averages(i)=nanmean(y(x>binedges(i)&x<binedges(i+1)));
    errors(i)=nansem(y(x>binedges(i)&x<binedges(i+1))).*sqrt(oversamplingratio);
end

hold on; errorbar(bincenters,averages,2.*errors,varargin{:})
