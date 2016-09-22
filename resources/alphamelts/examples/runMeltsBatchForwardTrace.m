function [melts, mass]=runMeltsBatchForwardTrace(i)


%%%%%%%%%%%%%%%%%%%%%%% pMelts equil. batch melting %%%%%%%%%%%%%%%%%%%%%%%
H2O=0.15; % Initial Water
Pi=rand*15000+20000; % Initial Pressure
% Starting composition
sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584; 0.0289; 0.0209; H2O;]; %mcdbse (McDonough Pyrolite)
% Elements to include in simulation (must match starting composition)
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
% Batch string
batch='1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n1.0\n0\n10\n0\n4\n0\n';
% Run simulation
melts=rmelts(sc,elems,'fo2path','None','batchstring',batch,'mode','isobaric','dT',-10,'Ti',1700,'Tf',800,'Pi',Pi,'simnumber',i);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Plot results
% plotelements={'SiO2','Al2O3','CaO','MgO','FeO','Na2O'};
% c=lines(length(plotelements));
% figure;
% for i=1:length(plotelements)
%     hold on; plot(melts.liquid_0.mass,melts.liquid_0.(plotelements{i}),'Color',c(i,:))
% end
% legend(plotelements)
% xlabel('Percent melt'); ylabel('wt. %');
% title([num2str(H2O) ' Percent  H2O,  ' num2str(Pi) '  bar'])
% tic;

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
    elseif ~isempty(strfind(lower(melts.minerals{i}),'rhm_oxide'))
        if isfield(melts.(melts.minerals{i}),'MnO')
            Ilmenite=(melts.(melts.minerals{i}).TiO2+melts.(melts.minerals{i}).MnO+(melts.(melts.minerals{i}).TiO2*(71.8444/79.8768)-melts.(melts.minerals{i}).MnO*(71.8444/70.9374)))/100;
            Magnetite=(melts.(melts.minerals{i}).FeO-(melts.(melts.minerals{i}).TiO2)*71.8444/79.8768)*(1+159.6882/71.8444)/100;
        else
            Ilmenite=(melts.(melts.minerals{i}).TiO2 + melts.(melts.minerals{i}).TiO2*71.8444/79.8768)/100;
            Magnetite=(melts.(melts.minerals{i}).FeO-melts.(melts.minerals{i}).TiO2*71.8444/79.8768)*(1+159.6882/71.8444)/100;
        end
        Magnetite(Magnetite<0)=0;
        Hematite=(melts.(melts.minerals{i}).Fe2O3-Magnetite*100*159.6882/231.5326)/100;
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
    if isempty(strfind(melts.minerals{i},'liquid')) && isempty(strfind(melts.minerals{i},'water')) && isempty(strfind(melts.minerals{i},'feldspar')) && isempty(strfind(melts.minerals{i},'rhm-oxide'))
        mass.solids=mass.solids+mass.(melts.minerals{i});
    end
end