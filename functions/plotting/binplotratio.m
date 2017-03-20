function binplotratio(x,num,den,xmin,xmax,oversamplingratio,nbins,varargin)

binwidth=(xmax-xmin)/nbins;
binedges=linspace(xmin,xmax,nbins+1);
bincenters=xmin+binwidth/2:binwidth:xmax-binwidth/2;

averages=NaN(1,nbins);
errors=NaN(1,nbins);

for i=1:nbins
    test = x>binedges(i)&x<binedges(i+1);
    averages(i)=nanmedian(num(test)./(num(test)+den(test)));
    errors(i)=nanmsem(num(test)./(num(test)+den(test))).*sqrt(oversamplingratio);
    
end

% Convert fractions back to ratios
[averages, errors] = fracttoratio(averages,errors);

errorbar(bincenters,averages,2.*errors,varargin{:})
