if ~exist('mcigncn1','var')
    load mcigncn1
end
if ~exist('igncn1','var')
    load igncn1
end

Elem='Cr';
agemin=0;
agemax=4000;

rsi=[43,51,62,74,80];
rsi=[40 80];
for i=1:length(rsi)-1
    test=mcigncn1.SiO2>rsi(i)&mcigncn1.SiO2<rsi(i+1)&mcigncn1.Elevation>-100&~isnan(mcigncn1.(Elem));
    [c,m,e]=bin(mcigncn1.Age(test),mcigncn1.(Elem)(test),agemin,agemax,length(mcigncn1.SiO2)./length(igncn1.SiO2),40);
    figure; errorbar(c,m,2*e,'.r')
    title([num2str(rsi(i)) '-' num2str(rsi(i+1)) '% SiO2']); xlabel('Age (Ma)'); ylabel(Elem)
end
set(gca,'xdir','reverse');