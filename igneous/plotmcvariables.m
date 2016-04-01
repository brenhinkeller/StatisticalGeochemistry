if ~exist('mcign','var')
    load mcign
end
if ~exist('ign','var')
    load ign
end
Num='La';
Den='Yb';

agemin=0;
agemax=4000;
nbins=40;


rsi=[43,51,62,74,80];
for i=1:length(rsi)-1
    test=mcign.SiO2>rsi(i)&mcign.SiO2<rsi(i+1)&mcign.Elevation>-100&~isnan(mcign.(Num))&~isnan(mcign.(Den));
    [c,m,e]=bin(mcign.Age(test),mcign.(Num)(test)./(mcign.(Num)(test)+mcign.(Den)(test)),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins); [m,e]=fracttoratio(m,e);
    figure; errorbar(c,m,2*e,'.r')
    title([num2str(rsi(i)) '-' num2str(rsi(i+1)) '% SiO2']); xlabel('Age (Ma)'); ylabel([Num ' / ' Den])
    formatfigure
    xlim([agemin agemax])
end