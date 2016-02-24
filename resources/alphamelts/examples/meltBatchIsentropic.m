Pi=40000; % Initial pressure
Pf=100; % Final pressure
potentialtemp=1350; % Potential temperature
%%%%%%%%%%%%%%%%%%%%%%%% pMelts batch isentropic %%%%%%%%%%%%%%%%%%%%%%%%%%
H2O=.15; % Initial water
% Starting Composition
sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584; 0.0289; 0.0209; H2O;];
% Elements to include in simulation (must match starting composition)
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
% Batch string for isentropic melting
batch=['1\nsc.melts\n9\n0\n2\n0\n1\n3\n0\nolivine\northopyroxene\nclinopyroxene\nspinel\nfeldspar\nx\n7\n-1\n9\n1\n2\n0\n' num2str(Pi) '\n3\n4\n0\n'];
% Run simulation
melts=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','isentropic','dP',-200,'Ti',potentialtemp,'Pi',Pi,'Pf',Pf);
% Notes: fO2 buffer needed when including K2O, P2O5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot results
plotelements={'SiO2','Al2O3','CaO','MgO','FeO','Na2O'};
c=lines(6);
figure;
for i=1:6
    hold on; plot(melts.liquid_0.mass,melts.liquid_0.(plotelements{i}),'Color',c(i,:))
end
legend(plotelements)
title([num2str(H2O) ' Percent  H2O, ' num2str(potentialtemp) ' C Tp']);



figure; [ax,h1,h2]=plotyy(melts.liquid_0.Pressure,melts.liquid_0.mass,melts.liquid_0.Pressure,melts.liquid_0.Temperature);
xlabel('Pressure (bar)'); ylabel(ax(1),'Percent Melt'); ylabel(ax(2),'Temperature (C)'); 
title([num2str(H2O) ' Percent  H2O, ' num2str(potentialtemp) ' C Tp']);
