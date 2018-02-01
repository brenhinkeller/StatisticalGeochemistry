%% %%%%%%%%%%%%%%%%%%%% pMelts equil. batch melting %%%%%%%%%%%%%%%%%%%%%%%
H2O=0.15; % Initial Water
Pi=20000; % Initial Pressure
% Starting composition
sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584; 0.0289; 0.0209; H2O;]; %mcdbse (McDonough Pyrolite)
% Elements to include in simulation (must match starting composition)
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
% Batch string
batch='1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n1.0\n0\n10\n0\n4\n0\n';
% Run simulation
melts=rmelts(sc,elems,'fo2path','None','batchstring',batch,'mode','isobaric','dT',-10,'Ti',1700,'Tf',800,'Pi',Pi);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot results
plotelements={'SiO2','Al2O3','CaO','MgO','FeO','Na2O','K2O'};
c=lines(length(plotelements));
figure;
for i=1:length(plotelements)
    hold on; plot(melts.liquid_0.mass,melts.liquid_0.(plotelements{i}),'Color',c(i,:))
end
legend(plotelements)
title([num2str(H2O) ' Percent  H2O,  ' num2str(Pi) '  bar'])
xlabel('Percent melt')
ylabel('Abudance (wt. %)')
xlim([0 100])


%% %%%%%%%%%%%%%%%%%%%% pMelts equil. batch melting %%%%%%%%%%%%%%%%%%%%%%%
H2O=3; % Initial Water
Pi=16000; % Initial Pressure
% Starting composition
sc  =  [51.33; 0.980; 15.700; 0.0000; 0.0585; 8.72; 0.17; 9.48; 0.02; 0.00; 9.93; 2.610; 0.88; 0.220; H2O;]; % Kelemen primitive basalt
% Elements to include in simulation (must match starting composition)
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';'MnO';'MgO';'NiO';'CoO';'CaO';'Na2O';'K2O';'P2O5';'H2O';};
% Batch string
batch='1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n1.0\n0\n10\n0\n4\n0\n';
% Run simulation
melts=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','isobaric','dT',-10,'Ti',1700,'Tf',600,'Pi',Pi);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot results
plotelements={'SiO2','TiO2','Al2O3','CaO','MgO','FeO','Na2O','K2O'};
c=lines(length(plotelements));
figure;
for i=1:length(plotelements)
    hold on; plot(melts.liquid_0.mass,melts.liquid_0.(plotelements{i}),'Color',c(i,:))
end
legend(plotelements)
title([num2str(H2O) ' Percent  H2O,  ' num2str(Pi) '  bar'])
xlabel('Percent melt')
ylabel('Abudance (wt. %)')
xlim([0 100])
