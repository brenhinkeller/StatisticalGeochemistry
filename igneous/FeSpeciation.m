
%% Load igneous data and check to exclude samples with blanket Fe3/Fe2 ratio 
if ~exist('mcign','var'); load mcign; end
if ~exist('ign','var'); load ign; end

t = ~isnan(ign.Fe2O3) & ~isnan(ign.FeO) & ign.Elevation>-100;

data = struct;
data.Kv = ign.Kv(t);
data.FeO = ign.FeO(t);
data.Fe2O3 = ign.Fe2O3(t);
data.Fe2O3_FeO = ign.Fe2O3(t)./ign.FeO(t);
data.Latitude = ign.Latitude(t);
data.Longitude = ign.Longitude(t);
data.Reference = igntext.Reference(t);
data.elements=fieldnames(data);


refs = unique(data.Reference);

relrefvar = NaN(length(refs),1);

for i=1:length(refs)
    t = strcmp(refs{i},data.Reference);
    if sum(t)>1
        relrefvar(i) = nanvar(data.Fe2O3_FeO(t))./nanmean(data.Fe2O3_FeO(t));
    end
end

badrefs = refs(relrefvar<0.01);

badkvs = [];
for i=1:length(badrefs)
    badkvs = unique([badkvs; ign.Kv(strcmp(badrefs{i},data.Reference))]);
end

NExcludedPoints = length(badkvs)
       
badkvtest = false(size(mcign.Fe2O3));
for i=1:length(badkvs)
    badkvtest = badkvtest | (mcign.Kv == badkvs(i));
end

% Find which samples are volcanic vs. plutonic
% if ~(isfield(mcign,'p') && isfield(mcign,'v'))
    if ~exist('igntext','var'); load igntext; end
    
    Kv = str2double(regexprep(igntext.KV,'KV',''));
    v = strcmpi('volcanic',igntext.Type);
    p = strcmpi('plutonic',igntext.Type);
    
    i = findclosest(mcign.Kv,Kv);
    
    mcign.p = p(i);
    mcign.v = v(i);
% end

%% Check subaerial fraction

Num='FeO';
Den='Fe2O3';
test=mcign.SiO2>40&mcign.SiO2<80&mcign.Elevation>-100&~isnan(mcign.(Num))&~isnan(mcign.(Den))&mcign.v&mcign.FeOT>1&mcign.FeOT<18;
subaerial = sum(test&mcign.Elevation>0&mcign.Age<0.1)/sum(test&mcign.Age<0.1)


%% Fe3/FeT over time for samples with 1-18% FeO


Num='Fe3';
Den='Fe2';

agemin=0;
agemax=4000;
nbins=40;
Ratio = 0;


mcign.Fe3 = mcign.Fe2O3 ./ (55.845 + 1.5*15.9994) *10;
mcign.Fe2 = mcign.FeO ./ (55.845 + 15.9994) *10;
mcign.FeT = mcign.Fe3 + mcign.Fe3;


data = struct;

% rsi=[43,51,62,74,80];
rsi=[40,80];
for i=1:length(rsi)-1
    test=mcign.SiO2>rsi(i)&mcign.SiO2<rsi(i+1)&mcign.Elevation>-100&~isnan(mcign.(Num))&~isnan(mcign.(Den))&mcign.p&~badkvtest&mcign.FeOT>1&mcign.FeOT<18;
%     test=mcign.SiO2>rsi(i)&mcign.SiO2<rsi(i+1)&mcign.Elevation>-100&~isnan(mcign.(Num))&~isnan(mcign.(Den))&mcign.p&mcign.FeOT>1&mcign.FeOT<18;
    
    [c,mt,~]=bin(mcign.Age(test),mcign.SiO2,agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
    data.Age = c;
    data.PlutonicSiO2Ave = mt;
    [~,mt,~]=bin(mcign.Age(test),mcign.FeOT,agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
    data.PlutonicFeOTAve = mt;

    
    [c,m,e]=bin(mcign.Age(test),mcign.(Num)(test)./(mcign.(Num)(test)+mcign.(Den)(test)),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins); if Ratio; [m e]=fracttoratio(m,e); end
    figure; errorbar(c,m,2*e,'.b')
    title([num2str(rsi(i)) '-' num2str(rsi(i+1)) '% SiO2 Plutonic']); xlabel('Age (Ma)');
    if Ratio; ylabel([Num ' / ' Den]); else ylabel([Num ' / ' Num ' + ' Den]); end
    formatfigure
    xlim([agemin agemax])
    
    data.PlutonicFe3_FeT = m;
    data.PlutonicFe3_FeT_Sigma = e;
    
%     set(gca,'xdir','reverse')

%     binwidth=(agemax-agemin)/nbins;
%     binedges=linspace(agemin,agemax,nbins+1);
%     bincenters=agemin+binwidth/2:binwidth:agemax-binwidth/2;
%     
%     x = mcign.Age(test);
%     for j=1:nbins
%         t = x>binedges(j)&x<binedges(j+1);
%         N(j)=sum(t);
% %         Kvs{j} = mcign.Kv(t);
%         Nunique(j) = length(unique(mcign.Kv(t)));
%     end
    
end
ylim([0.15 0.55])


% figure; plot(c,N)
% figure; plot(c,Nunique)


rsi=[40,80];
for i=1:length(rsi)-1
    test=mcign.SiO2>rsi(i)&mcign.SiO2<rsi(i+1)&mcign.Elevation>-100&~isnan(mcign.(Num))&~isnan(mcign.(Den))&mcign.v&~badkvtest&mcign.FeOT>1&mcign.FeOT<18;
%     test=mcign.SiO2>rsi(i)&mcign.SiO2<rsi(i+1)&mcign.Elevation>-100&~isnan(mcign.(Num))&~isnan(mcign.(Den))&mcign.v&mcign.FeOT>1&mcign.FeOT<18;

    data.VolcanicSiO2Ave = mt;
    [~,mt,~]=bin(mcign.Age(test),mcign.FeOT,agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
    data.VolcanicFeOTAve = mt;
    
    [c,m2,e2]=bin(mcign.Age(test),mcign.(Num)(test)./(mcign.(Num)(test)+mcign.(Den)(test)),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins); if Ratio; [m e]=fracttoratio(m,e); end
    figure; errorbar(c,m2,2*e2,'.r')
    title([num2str(rsi(i)) '-' num2str(rsi(i+1)) '% SiO2 Volcanic']); xlabel('Age (Ma)');
    if Ratio; ylabel([Num ' / ' Den]); else ylabel([Num ' / ' Num ' + ' Den]); end
    formatfigure
    xlim([agemin agemax])
%     set(gca,'xdir','reverse')

    data.VolcanicFe3_FeT = m2;
    data.VolcanicFe3_FeT_Sigma = e2;
end
ylim([0.15 0.55])

% figure; errorbar(c,m2-m,sqrt(e.^2-e2.^2))


data.elements = fieldnames(data);
exportdataset(data,'1.FilteredFe3_FeT1-18.csv',',');
% exportdataset(data,'2.UnfilteredFe3_FeT.csv',',');

%% Bin Fe3/FeT, weighted by FeOT
mcign.Fe3 = mcign.Fe2O3 ./ (55.845 + 1.5*15.9994) * 10;
mcign.Fe2 = mcign.FeO ./ (55.845 + 15.9994) * 10;
mcign.FeT = mcign.Fe3 + mcign.Fe3;

Num='Fe3';
Den='Fe2';

agemin=0;
agemax=4000;
nbins=40;
Ratio = 0;

% rsi=[43,51,62,74,80];
rsi=[40,80];
for i=1:length(rsi)-1
    test=mcign.SiO2>rsi(i)&mcign.SiO2<rsi(i+1)&mcign.Elevation>-100&~isnan(mcign.(Num))&~isnan(mcign.(Den))&mcign.p&mcign.FeOT>1;
    [c,m,e]=binweighted(mcign.Age(test),mcign.(Num)(test)./(mcign.(Num)(test)+mcign.(Den)(test)),1./mcign.FeOT(test),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins); if Ratio; [m e]=fracttoratio(m,e); end
    figure; errorbar(c,m,2*e,'.r')
    title([num2str(rsi(i)) '-' num2str(rsi(i+1)) '% SiO2 Plutonic']); xlabel('Age (Ma)');
    if Ratio; ylabel([Num ' / ' Den]); else ylabel([Num ' / ' Num ' + ' Den]); end
    formatfigure
    xlim([agemin agemax])
end

rsi=[40,80];
for i=1:length(rsi)-1
    test=mcign.SiO2>rsi(i)&mcign.SiO2<rsi(i+1)&mcign.Elevation>-100&~isnan(mcign.(Num))&~isnan(mcign.(Den))&mcign.v&mcign.FeOT>1;
    [c,m,e]=binweighted(mcign.Age(test),mcign.(Num)(test)./(mcign.(Num)(test)+mcign.(Den)(test)),1./mcign.FeOT(test),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins); if Ratio; [m e]=fracttoratio(m,e); end
    figure; errorbar(c,m,2*e,'.r')
    title([num2str(rsi(i)) '-' num2str(rsi(i+1)) '% SiO2 Volcanic']); xlabel('Age (Ma)');
    if Ratio; ylabel([Num ' / ' Den]); else ylabel([Num ' / ' Num ' + ' Den]); end
    formatfigure
    xlim([agemin agemax])
%     set(gca,'xdir','reverse')
end


%% Fe oxidation weighted by sensitivity

mcign.FeOxidationMolKg = mcign.FeT.*(mcign.Fe3./(mcign.Fe3+mcign.Fe2)-0.22);

Elem='FeOxidationMolKg';
agemin=0;
agemax=4000;
nbins = 40;

% rsi=[43,51,62,74,80];
rsi=[40,80];
i = 1;
test=mcign.SiO2>rsi(i)&mcign.SiO2<rsi(i+1)&mcign.Elevation>-100&~isnan(mcign.(Elem)) & mcign.p &mcign.FeOT>1&mcign.FeOT<18;
%test=test&~badkvtest;
[c,m,e]=binweighted(mcign.Age(test),mcign.(Elem)(test),1./(mcign.FeOT(test)),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
figure; errorbar(c,m,2*e,'.b')
title([num2str(rsi(i)) '-' num2str(rsi(i+1)) '% SiO2 Plutonic']); xlabel('Age (Ma)'); ylabel('Fe oxidation (mol/kg)')
ylim([0 0.4])
formatfigure;

data = struct;
data.Age = c;
data.PlutonicFeOxidation = m;
data.PlutonicFeOxidation_Sigma = e;


test=mcign.SiO2>rsi(i)&mcign.SiO2<rsi(i+1)&mcign.Elevation>-100&~isnan(mcign.(Elem)) & mcign.v &mcign.FeOT>1&mcign.FeOT<18;
%test=test&~badkvtest;
[c,m,e]=binweighted(mcign.Age(test),mcign.(Elem)(test),1./(mcign.FeOT(test)), agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
figure; errorbar(c,m,2*e,'.r')
title([num2str(rsi(i)) '-' num2str(rsi(i+1)) '% SiO2 Volcanic']); xlabel('Age (Ma)'); ylabel('Fe oxidation (mol/kg)');
ylim([0 0.4])
formatfigure;

data.VolcanicFeOxidation = m;
data.VolcanicFeOxidation_Sigma = e;

data.elements = fieldnames(data);
exportdataset(data,'5.FeOxidationMol_kg.csv',',');

%     set(gca,'xdir','reverse');

%% Differentiation as a function of time bin
rt=[0,541,1000,2500,4000]; % Time ranges

mcign.Fe3 = mcign.Fe2O3 ./ (55.845 + 1.5*15.9994) * 10;
mcign.Fe2 = mcign.FeO ./ (55.845 + 15.9994) * 10;
mcign.FeT = mcign.Fe3 + mcign.Fe3;

Num='Fe3';
Den='Fe2';
xElem = 'FeOT';
xmin = 0;
xmax = 16;
nbins = 10;

data = struct;
figure; hold on;
l = {};
for i=1:length(rt)-1
    t=mcign.Age>rt(i)&mcign.Age<rt(i+1)&mcign.Elevation>-100&mcign.v;
    %test=test&~badkvtest;
    
    [c,m,e]=bin(mcign.(xElem)(t),mcign.(Num)(t)./(mcign.(Num)(t)+mcign.(Den)(t)),xmin,xmax,length(mcign.SiO2)./length(ign.SiO2),nbins); if Ratio; [m e]=fracttoratio(m,e); end
    errorbar(c,m,2*e,'.')
    data.FeOT = c;
    data.(['VolcanicFe3_FeT' num2str(rt(i)) '_' num2str(rt(i+1)) 'Ma']) = m;
    data.(['VolcanicFe3_FeT' num2str(rt(i)) '_' num2str(rt(i+1)) 'Ma_Sigma']) = e;
    l = [l, {[num2str(rt(i)) '-' num2str(rt(i+1)) ' Ma']}];
end

ylim([0 0.8])
ylabel('Fe3+/FeT'); xlabel('FeO*');
legend(l); title('Volcanic');
formatfigure;


figure; hold on;
l = {};
for i=1:length(rt)-1
    t=mcign.Age>rt(i)&mcign.Age<rt(i+1)&mcign.Elevation>-100&mcign.p;
    %test=test&~badkvtest;
    
    [c,m,e]=bin(mcign.(xElem)(t),mcign.(Num)(t)./(mcign.(Num)(t)+mcign.(Den)(t)),xmin,xmax,length(mcign.SiO2)./length(ign.SiO2),nbins); if Ratio; [m e]=fracttoratio(m,e); end
    errorbar(c,m,2*e,'.')
    
    data.(['PlutonicFe3_FeT' num2str(rt(i)) '_' num2str(rt(i+1)) 'Ma']) = m;
    data.(['PlutonicFe3_FeT' num2str(rt(i)) '_' num2str(rt(i+1)) 'Ma_Sigma']) = e;
    l = [l, {[num2str(rt(i)) '-' num2str(rt(i+1)) ' Ma']}];
end

data.elements = fieldnames(data);
exportdataset(data,'4.Fe3_FeTvsFeOT.csv',',');

ylim([0 0.8])
ylabel('Fe2O3/(FeO+Fe2O3)'); xlabel('FeO*');
legend(l); title('Plutonic')
formatfigure;

%% Histograms for discrete time bins
rt=[0,541,1000,2500,4000];
nbins = 10;
edges =  0:1/nbins:1;


mcign.Fe3 = mcign.Fe2O3 ./ (55.845 + 1.5*15.9994) * 10;
mcign.Fe2 = mcign.FeO ./ (55.845 + 15.9994) * 10;
mcign.FeT = mcign.Fe3 + mcign.Fe3;

% All
figure; subplot(2,2,1);
data = struct;
data.Fe3_FeT = center(edges);
for i=1:length(rt)-1
    t=mcign.Age>rt(i)&mcign.Age<rt(i+1)&mcign.Elevation>-100;
    %test=test&~badkvtest;
    % Plot results
    subplot(2,2,i); hist(mcign.Fe3(t)./(mcign.Fe2(t)+mcign.Fe3(t)),nbins);
    title([num2str(rt(i)) '-' num2str(rt(i+1)) ' Ma']); xlabel('Fe3+/FeT'); ylabel('N (resampled)')
    % Save results
    counts = histcounts(mcign.Fe3(t)./(mcign.Fe2(t)+mcign.Fe3(t)),edges);
    data.(['N_' num2str(rt(i)) '_' num2str(rt(i+1)) 'Ma']) = counts;
end

% Volcanic
figure; subplot(2,2,1);
for i=1:length(rt)-1
    t=mcign.Age>rt(i)&mcign.Age<rt(i+1)&mcign.Elevation>-100&mcign.v;
    %test=test&~badkvtest;
    % Plot results
    subplot(2,2,i); hist(mcign.Fe3(t)./(mcign.Fe2(t)+mcign.Fe3(t)),nbins);
    title([num2str(rt(i)) '-' num2str(rt(i+1)) ' Ma Volcanic']); xlabel('Fe3+/FeT'); ylabel('N (resampled)')
    % Save results
    counts = histcounts(mcign.Fe3(t)./(mcign.Fe2(t)+mcign.Fe3(t)),edges);
    data.(['NVolcanic_' num2str(rt(i)) '_' num2str(rt(i+1)) 'Ma']) = counts;
end

% Plutonic
figure; subplot(2,2,1);
for i=1:length(rt)-1
    t=mcign.Age>rt(i)&mcign.Age<rt(i+1)&mcign.Elevation>-100&mcign.p;
    %test=test&~badkvtest;
    % Plot results
    subplot(2,2,i); hist(mcign.Fe3(t)./(mcign.Fe2(t)+mcign.Fe3(t)),nbins);
    title([num2str(rt(i)) '-' num2str(rt(i+1)) ' Ma Plutonic']); xlabel('Fe3+/FeT'); ylabel('N (resampled)')
    % Save results
    counts = histcounts(mcign.Fe3(t)./(mcign.Fe2(t)+mcign.Fe3(t)),edges);
    data.(['NPlutonic_' num2str(rt(i)) '_' num2str(rt(i+1)) 'Ma']) = counts;
end

data.elements = fieldnames(data);
exportdataset(data,'3.ResampledFe3_FeTHistograms.csv',',');


%