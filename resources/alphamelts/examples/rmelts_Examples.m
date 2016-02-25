%% Melt the mantle with equilbrium batch melting

%%%%%%%%%%%% pMelts equilibrium batch melting/crystallization %%%%%%%%%%%%%
H2O=0.15; % Initial Water
Pi=30000; % Initial Pressure
% Starting composition
sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584; 0.0289; 0.0209; H2O;]; % Mantle (McDonough Pyrolite)
% Elements to include in simulation (must match starting composition)
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
% Batch string
batch='1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n1.0\n0\n10\n0\n4\n0\n';
% Run simulation
melts=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','isobaric','dT',-10,'Ti',1700,'Tf',800,'Pi',Pi);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot results
plotelements={'SiO2','Al2O3','CaO','MgO','FeO','Na2O'};
c=lines(6);
figure;
for i=1:6
    hold on; plot(melts.liquid_0.mass,melts.liquid_0.(plotelements{i}),'Color',c(i,:))
end
legend(plotelements)
title([num2str(H2O) ' Percent  H2O,  ' num2str(Pi) '  bar'])
xlabel('Percent melt')
ylabel('wt. %')
set(gca,'XDir','reverse')
xlim([0 100])



%% Crystallize a magma from the liquidus

%%%%%%%%%%%% pMelts equilibrium batch melting/crystallization %%%%%%%%%%%%%
Pi=2000; % Initial Pressure
% Starting composition
sc=[49.0655065117512;1.44466315993097;14.6640887531477;4.81928829579814;0.111257150218812;7.63651914194764;0.187014754311165;7.74230950232717;0.0486686120740908;0.00699145313531872;9.40321227322477;2.66309148709078;0.994818208787844;0.291792101910444;1.84730867279438]; % Average basalt
% sc=[68.3654108860589;0.456031328549272;14.9467724183609;2.03452026831002;0.0235682980486470;1.89034573109518;0.0763174144740371;1.16396812572910;0.00559327496854337;0.00156635613340519;2.56042712415867;3.82539193655613;3.40030351338466;0.152234810405391;1.01807947623329]; % Average granite

% Elements to include in simulation (must match starting composition)
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
% Batch string
batch='1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n1.0\n0\n10\n0\n4\n0\n';
% Run simulation
melts=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','isobaric','dT',-10,'Ti',1700,'Tf',500,'Pi',Pi);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot results
plotelements={'SiO2','Al2O3','CaO','MgO','FeO','Na2O'};
c=lines(6);
figure;
for i=1:6
    hold on; plot(melts.liquid_0.mass,melts.liquid_0.(plotelements{i}),'Color',c(i,:))
end
legend(plotelements)
title(['Batch crystallization,  ' num2str(Pi) '  bar'])
xlabel('Percent melt')
ylabel('wt. %')
set(gca,'XDir','reverse')
xlim([0 100])


%% Fractional crystallization of a magma from the liquidus


%%%%%%%%%%%%%%%%%%% pMelts fractional crystallization %%%%%%%%%%%%%%%%%%%%%
Pi=2000; % Initial Pressure
% Starting composition
sc=[49.0655065117512;1.44466315993097;14.6640887531477;4.81928829579814;0.111257150218812;7.63651914194764;0.187014754311165;7.74230950232717;0.0486686120740908;0.00699145313531872;9.40321227322477;2.66309148709078;0.994818208787844;0.291792101910444;1.84730867279438]; % Average basalt
% sc=[68.3654108860589;0.456031328549272;14.9467724183609;2.03452026831002;0.0235682980486470;1.89034573109518;0.0763174144740371;1.16396812572910;0.00559327496854337;0.00156635613340519;2.56042712415867;3.82539193655613;3.40030351338466;0.152234810405391;1.01807947623329]; % Average granite

% Elements to include in simulation (must match starting composition)
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
% Batch string
batch='1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n1.0\n0\n10\n0\n4\n0\n';
% Run simulation
melts=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','isobaric','dT',-10,'Ti',1700,'Tf',500,'Pi',Pi,'fractionatesolids','');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot results
plotelements={'SiO2','Al2O3','CaO','MgO','FeO','Na2O'};
c=lines(6);
figure;
for i=1:6
    hold on; plot(melts.liquid_0.mass,melts.liquid_0.(plotelements{i}),'Color',c(i,:))
end
legend(plotelements)
title(['Fractional crystallization,  ' num2str(Pi) '  bar'])
xlabel('Percent melt')
ylabel('wt. %')
set(gca,'XDir','reverse')
xlim([0 100])




