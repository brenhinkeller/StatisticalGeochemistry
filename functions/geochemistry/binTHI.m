function [bincenters,averages,errors]=binTHI(x,MgO,FeO,min,max,oversamplingratio,nbins)

binwidth=(max-min)/nbins;
binedges=linspace(min,max,nbins+1);
bincenters=min+binwidth/2:binwidth:max-binwidth/2;

averages=NaN(1,nbins);
errors=NaN(1,nbins);



for i=1:nbins
    Fe4 = FeO(x>binedges(i)&x<binedges(i+1)&MgO>3.5&MgO<4.5);
    Fe8 = FeO(x>binedges(i)&x<binedges(i+1)&MgO>7.5&MgO<8.5);
    averages(i)=nanmean(Fe4)/nanmean(Fe8);
    errors(i)=averages(i)*sqrt((nansem(Fe4).*sqrt(oversamplingratio)/nanmean(Fe4))^2 + (nansem(Fe8).*sqrt(oversamplingratio)/nanmean(Fe8))^2);
end
