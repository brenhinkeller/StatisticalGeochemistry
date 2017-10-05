if ~exist('mcigncn1','var')
    load mcigncn1
end
if ~exist('igncn1','var')
    load igncn1
end

Elem={'U','Th','K2O'};
agemin=0;
agemax=4000;
nbins = 40;

rsi=[40,80];

data = struct;g
for i=1:length(Elem)
    test=mcigncn1.SiO2>rsi(1)&mcigncn1.SiO2<rsi(2)&mcigncn1.Elevation>-100&~isnan(mcigncn1.(Elem{i}));
    [c,m,e]=bin(mcigncn1.Age(test),mcigncn1.(Elem{i})(test),agemin,agemax,length(mcigncn1.SiO2)./length(igncn1.SiO2),nbins);
    data.Age = c;
    data.(Elem{i}) = m;
    data.([Elem{i} '_sigma']) = e;
    figure; errorbar(c,m,2*e,'.r')
    xlim([agemin agemax])
    title([num2str(rsi(1)) '-' num2str(rsi(2)) '% SiO2']); xlabel('Age (Ma)'); ylabel(Elem{i})
end

data.elements = fieldnames(data);
exportdataset(data,[num2str(rsi(1)) '-' num2str(rsi(2)) '%SiO2CrustalAverage.csv'],',')

