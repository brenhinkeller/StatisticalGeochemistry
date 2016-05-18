%%%%%%%%%%%%%%%%%%%%%%% pMelts equil. batch melting %%%%%%%%%%%%%%%%%%%%%%%
H2O=0.15; % Initial Water
Pi=27000; % Initial Pressure
% Starting composition
sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584; 0.0289; 0.0209; H2O;]; %mcdbse (McDonough Pyrolite)
% Elements to include in simulation (must match starting composition)
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
% Batch string
batch='1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n1.0\n0\n10\n0\n4\n0\n';
% Run simulation
melts=rmelts(sc,elems,'fo2path','None','batchstring',batch,'mode','isobaric','dT',-10,'Ti',1700,'Tf',800,'Pi',Pi);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot MELTS results
plotelements={'SiO2','Al2O3','CaO','MgO','FeO','Na2O'};
c=lines(length(plotelements));
figure;
for i=1:length(plotelements)
    hold on; plot(melts.liquid_0.mass,melts.liquid_0.(plotelements{i}),'Color',c(i,:))
end
legend(plotelements)
xlabel('Percent melt'); ylabel('wt. %');
title([num2str(H2O) ' Percent  H2O,  ' num2str(Pi) '  bar'])


% Determine minimum and maximum temperature in the simulation
minT=NaN;
maxT=NaN;
for i=1:length(melts.minerals)
    maxT=max([maxT max(melts.(melts.minerals{i}).Temperature)]);
    minT=min([minT min(melts.(melts.minerals{i}).Temperature)]);
end

% Determine temperature step
if range(melts.liquid_0.Temperature(1:end-1)-melts.liquid_0.Temperature(2:end))<10^-5
    deltaT=melts.liquid_0.Temperature(1)-melts.liquid_0.Temperature(2);
    simlength=round((maxT-minT)./deltaT)+1;
else
    error('Non-uniform temperature step');
end

% Calculate individual components for feldspar and oxides
An_Ca=(220.1298+56.18)/56.18;
Ab_Na=(228.2335+30.99)/30.99;
Or_K=(228.2335+47.1)/47.1;
for i=1:length(melts.minerals)
    if ~isempty(strfind(lower(melts.minerals{i}),'feldspar')) && ~isfield(melts, 'anorthite')
        feldsparComp=bsxfun(@rdivide, [melts.(melts.minerals{i}).CaO*An_Ca melts.(melts.minerals{i}).Na2O*Ab_Na melts.(melts.minerals{i}).K2O*Or_K], (melts.(melts.minerals{i}).CaO*An_Ca + melts.(melts.minerals{i}).Na2O*Ab_Na + melts.(melts.minerals{i}).K2O*Or_K));
        melts.(['anorthite' melts.minerals{i}(9:end)]).mass=melts.(melts.minerals{i}).mass.*feldsparComp(:,1);
        melts.(['anorthite' melts.minerals{i}(9:end)]).Temperature=melts.(melts.minerals{i}).Temperature;
        melts.(['albite' melts.minerals{i}(9:end)]).mass=melts.(melts.minerals{i}).mass.*feldsparComp(:,2);
        melts.(['albite' melts.minerals{i}(9:end)]).Temperature=melts.(melts.minerals{i}).Temperature;
        melts.(['orthoclase' melts.minerals{i}(9:end)]).mass=melts.(melts.minerals{i}).mass.*feldsparComp(:,3);
        melts.(['orthoclase' melts.minerals{i}(9:end)]).Temperature=melts.(melts.minerals{i}).Temperature;
        melts.minerals=unique([melts.minerals; ['anorthite' melts.minerals{i}(9:end)]; ['albite' melts.minerals{i}(9:end)]; ['orthoclase' melts.minerals{i}(9:end)];],'stable');
    elseif ~isempty(strfind(lower(melts.minerals{i}),'rhmoxide'))
        Ilmenite=(melts.rhmoxide0.TiO2+melts.rhmoxide0.MnO+(melts.rhmoxide0.TiO2*(71.8444/79.8768)-melts.rhmoxide0.MnO*(71.8444/70.9374)))/100;
        Magnetite=(melts.rhmoxide0.FeO-(melts.rhmoxide0.TiO2-melts.rhmoxide0.MnO*79.8768/70.9374)*71.8444/79.8768)*(1+159.6882/71.8444)/100;
        Magnetite(Magnetite<0)=0;
        Hematite=(melts.rhmoxide0.Fe2O3-Magnetite*100*159.6882/231.5326)/100;
        melts.(['ilmenite' melts.minerals{i}(9:end)]).mass=melts.(melts.minerals{i}).mass.*Ilmenite;
        melts.(['ilmenite' melts.minerals{i}(9:end)]).Temperature=melts.(melts.minerals{i}).Temperature;
        melts.(['magnetite' melts.minerals{i}(9:end)]).mass=melts.(melts.minerals{i}).mass.*Magnetite;
        melts.(['magnetite' melts.minerals{i}(9:end)]).Temperature=melts.(melts.minerals{i}).Temperature;
        melts.(['hematite' melts.minerals{i}(9:end)]).mass=melts.(melts.minerals{i}).mass.*Hematite;
        melts.(['hematite' melts.minerals{i}(9:end)]).Temperature=melts.(melts.minerals{i}).Temperature;
        melts.minerals=unique([melts.minerals; ['ilmenite' melts.minerals{i}(9:end)]; ['magnetite' melts.minerals{i}(9:end)]; ['hematite' melts.minerals{i}(9:end)];],'stable');
    end
end

% Make a new struct containing zero-extended mineral masses
mass=struct;
mass.minerals=melts.minerals;
mass.solids=zeros(simlength,1);
for i=1:length(melts.minerals)
    melts.(melts.minerals{i}).Index=round((maxT-melts.(melts.minerals{i}).Temperature)./deltaT)+1;
    mass.(melts.minerals{i})=zeros(simlength,1);
    mass.(melts.minerals{i})(melts.(melts.minerals{i}).Index)=melts.(melts.minerals{i}).mass;
    if isempty(strfind(melts.minerals{i},'liquid')) && isempty(strfind(melts.minerals{i},'water'))
        mass.solids=mass.solids+mass.(melts.minerals{i});
    end
end



% Plot results
plotminerals={'olivine','orthopyroxene','clinopyroxene','garnet','spinel'};
c=lines(length(plotminerals));
figure;
for i=1:length(plotminerals)
    mInds=find(~cellfun('isempty', strfind(mass.minerals,lower(plotminerals{i}))));
    minMass=zeros(size(mass.solids));
    for j=1:length(mInds)
        minMass=minMass+mass.(mass.minerals{mInds(j)});
    end   
    hold on; plot(mass.liquid_0,minMass./mass.solids*100,'Color',c(i,:))
end
legend(plotminerals)
xlabel('Percent Mantle Melt'); ylabel('wt. % of solids')
xlim([0 60])

figure;
plot(melts.liquid_0.mass,melts.liquid_0.Temperature,'r')
xlim([0 60])
xlabel('Percent Mantle Melt'); ylabel('Temperature')
ylim([1200 1620])

%%
traceelements={'La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Sc','V','Cr','Co','Ni','Cu','Zn','Ga','Zr','Rb','Ba','Y','Pb','Nb','Sr','Ta','Mo','U','Cs','W','Th','Hf'};
% traceelements={'Rb','Ba','Th','U','K','Nb','Ta','La','Ce','Pb','Nd','Sr','Sm','Zr','Eu','Gd','Ti','Dy','Y','Er','Yb','Lu'}; % Elliott Elements
% traceelements={'Cs','Rb','K','Ba','Sr','La','Sm','Tb','Y','Yb','Nb'}; % Tatsumi elements
% traceelements={'Rb','K','Na','Li','Ba','Sr'}; %Mobile elements
% traceelements={'Hf','Zr','Ti','Ta','Nb'}; % Nonmobile elements

index=melts.liquid_0.Index;
meltSiInd=round(melts.liquid_0.SiO2)-39;
meltSiInd(meltSiInd<1)=1;
load partitioncoeffs
load mcdbse


for elem=traceelements;
    % Calculate bulk partition coeff.
    D.(elem{:})=zeros(size(index));
    for i=1:length(p.minerals)
        mnrlindxs=find(~cellfun('isempty',strfind(melts.minerals, lower(p.minerals{i}))));
        for k=1:length(mnrlindxs)
            % Note that minerals that we don't have data for end up being
            % treated like all elements are incompatible in them.
            % Note, geometric mean = log average
            D.(elem{:})=nansum([D.(elem{:}) mass.(mass.minerals{mnrlindxs(k)})(index)./mass.solids(index) .* (10.^p.(p.minerals{i}).(elem{:})(meltSiInd)) ],2);
        end
    end
    
end


F=melts.liquid_0.mass/100;

% Calculate trace elements as a function of melt fraction
for elem=traceelements; 
    initial.(elem{:})=1*mcdbse.(elem{:});
    calculated.(elem{:})=initial.(elem{:}) ./ (D.(elem{:}) .* (1-F)+F);
end

% Find calculated melt fractions closest to inverted melt fractions
if ~exist('mcmelt27k','var'); load mcmelt27kign; end;
t=mcmelt27k.bincenters;
F_t=nanmean(mcmelt27k.simaverages(:,:,1),1)'/100;
indT=findclosest(F_t,F);

% Load dataset
if ~exist('mcign','var'); load mcign; end
if ~exist('ign','var'); load ign; end
test=mcign.SiO2>43&mcign.SiO2<51&mcign.Elevation>-100;

mcign.K=mcign.K2O*10000*39.1./47.1;
mcign.Ti=mcign.TiO2*10000*47.87./79.87;
mcign.Na=mcign.Na2O*10000*22.989/38.989;

% Estimate source mantle enrichment factor for each element
enrichment=zeros(size(traceelements));
for i=1:length(traceelements)
    [~,m,~]=bin(mcign.Age(test),mcign.(traceelements{i})(test),0,4000,length(mcign.SiO2)./length(ign.SiO2),40);
    enrichment(i)=nanmean(m'./calculated.(traceelements{i})(indT));  
end

% Calculate melt compositions using enriched source
for i=1:length(traceelements); 
    initial.(traceelements{i})=enrichment(i)*mcdbse.(traceelements{i});
    calculated.(traceelements{i})=initial.(traceelements{i}) ./ (D.(traceelements{i}) .* (1-F)+F);
end

% Calculate remaining misfit
misfit=zeros(size(traceelements));
for i=1:length(traceelements)
    [~,m,~]=bin(mcign.Age(test),mcign.(traceelements{i})(test),0,4000,length(mcign.SiO2)./length(ign.SiO2),40);
    misfit(i)=nansum((1-m'./calculated.(traceelements{i})(indT)).^2);  
end


% Plot results
for elem=traceelements;
    figure; plot(t, calculated.(elem{:})(indT),'r')
    xlabel('Age (Ma)'); ylabel(elem);
    [c,m,e]=bin(mcign.Age(test),mcign.(elem{:})(test),0,4000,length(mcign.SiO2)./length(ign.SiO2),40);
    hold on; errorbar(c,m,2*e,'.b')
end

%% Figures for goldschmidt talk
figure; plot(melts.liquid_0.mass, log10(D.La),'r')
hold on; plot(melts.liquid_0.mass, log10(D.Yb),'g')
hold on; plot(melts.liquid_0.mass, log10(D.Sm),'m')
hold on; plot(melts.liquid_0.mass, log10(D.Zr),'b')
legend('La','Yb','Sm','Zr')

xlabel('Percent Melt'); ylabel('log10 D')

% figure; plot(F*100, La./Yb)
% xlabel('Percent Melt'); ylabel('La / Yb')

figure; plot(melts.liquid_0.mass, D.La./D.Yb,'k')
xlabel('Percent Melt'); ylabel('D La / D Yb')

figure; errorbar(mcmelt27k.bincenters, nanmean(mcmelt27k.simaverages(:,:,1),1), 2*nanmean(mcmelt27k.simerrors(:,:,1),1),'.r')
xlabel('Age (Ma)'); ylabel('Apparent Mantle Melt (%)')


[c,m,e]=bin(mcign.Age(test),mcign.La(test)./(mcign.La(test)+mcign.Yb(test)),0,4000,length(mcign.SiO2)./length(ign.SiO2),40); [m,e]=fracttoratio(m,e);
distScaling=nanmean(m'./(calculated.La(indT)./calculated.Yb(indT)));
figure; plot(t,calculated.La(indT)./calculated.Yb(indT).*distScaling,'r')
hold on; errorbar(c,m,2*e,'.b')
xlabel('Age (Ma)'); ylabel('La / Yb');

[c,m,e]=bin(mcign.Age(test),mcign.La(test)./(mcign.La(test)+mcign.Sm(test)),0,4000,length(mcign.SiO2)./length(ign.SiO2),40); [m,e]=fracttoratio(m,e);
distScaling=nanmean(m'./(calculated.La(indT)./calculated.Sm(indT)));
figure; plot(t,calculated.La(indT)./calculated.Sm(indT).*distScaling,'r')
hold on; errorbar(c,m,2*e,'.b')
xlabel('Age (Ma)'); ylabel('La / Sm');

[c,m,e]=bin(mcign.Age(test),mcign.Sm(test)./(mcign.Sm(test)+mcign.Yb(test)),0,4000,length(mcign.SiO2)./length(ign.SiO2),40); [m,e]=fracttoratio(m,e);
distScaling=nanmean(m'./(calculated.Sm(indT)./calculated.Yb(indT)));
figure; plot(t,calculated.Sm(indT)./calculated.Yb(indT).*distScaling,'r')
hold on; errorbar(c,m,2*e,'.b')
xlabel('Age (Ma)'); ylabel('Sm / Yb');

[c,m,e]=bin(mcign.Age(test),mcign.Rb(test)./(mcign.Nb(test)+mcign.Rb(test)),0,4000,length(mcign.SiO2)./length(ign.SiO2),40); [m,e]=fracttoratio(m,e);
distScaling=nanmean(m'./(calculated.Rb(indT)./calculated.Nb(indT)));
figure; plot(t,calculated.Rb(indT)./calculated.Nb(indT).*distScaling,'r')
hold on; errorbar(c,m,2*e,'.b')
xlabel('Age (Ma)'); ylabel('Rb / Nb');

[c,m,e]=bin(mcign.Age(test),mcign.Rb(test)./(mcign.Sr(test)+mcign.Rb(test)),0,4000,length(mcign.SiO2)./length(ign.SiO2),40); [m,e]=fracttoratio(m,e);
distScaling=nanmean(m'./(calculated.Rb(indT)./calculated.Sr(indT)));
figure; plot(t,calculated.Rb(indT)./calculated.Sr(indT).*distScaling,'r')
hold on; errorbar(c,m,2*e,'.b')
xlabel('Age (Ma)'); ylabel('Rb / Sr');

[c,m,e]=bin(mcign.Age(test),mcign.Nb(test)./(mcign.Th(test)+mcign.Nb(test)),0,4000,length(mcign.SiO2)./length(ign.SiO2),40); [m,e]=fracttoratio(m,e);
distScaling=nanmean(m'./(calculated.Nb(indT)./calculated.Th(indT)));
figure; plot(t,calculated.Nb(indT)./calculated.Th(indT).*distScaling,'r')
hold on; errorbar(c,m,2*e,'.b')
xlabel('Age (Ma)'); ylabel('Nb / Th');

figure; plot(enrichment)
set(gca,'xtick',1:length(enrichment))
set(gca,'xticklabel',traceelements)