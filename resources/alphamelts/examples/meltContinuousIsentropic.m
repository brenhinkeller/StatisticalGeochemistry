%% Continuous fractional isentropic melting
tic;
Pi=40000; % Initial pressure
Pf=0000; % Final Pressure
potentialtemp=1350; % Potenital temperature

% %%%%%%%%%%%%%%%%%%%%%% pHMelts continuous isentropic %%%%%%%%%%%%%%%%%%%%%%
% tH2O=1; % Use trace H2Oi
% PPMH2O=1500; % Initial trace H2O (in PPM)i
% % Starting composition
% sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584;];
% % Elements to include in simulation (must match above)
% elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O';};
% % Trace element starting composition
% tsc = [50; 20;];
% % Trace elements to include in simulation (must match above)
% telems={'K'; 'P';};
% % Batch string for continuous isentropic pHMelts
% %                  liq.off P=1bar                                                                                     H2O=15O                  P=Pi          liq.on Run      .                
% batch=['1\nsc.melts\n9\n0\n2\n0\n1\n3\n0\nolivine\northopyroxene\nclinopyroxene\nspinel\nfeldspar\nx\n7\n-1\n6\n' num2str(PPMH2O) '\n2\n0\n' num2str(Pi) '\n3\n9\n1\n4\n0\n'];
% % Run simulation
% melts=rmelts(sc,elems,'fo2path','None','batchstring',batch,'dotraceh2o','','mode','isentropic','continuous','','dP',-200,'Ti',potentialtemp,'Pi',Pi,'Pf',Pf);
% % melts=rmelts(sc,elems,'fo2path','None','batchstring',batch,'dotrace','','dotraceh2o','','tsc',tsc,'telems',telems,'mode','isentropic','continuous','','dP',-200,'Ti',potentialtemp,'Pi',Pi,'Pf',Pf);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%% pMelts continuous isentropic %%%%%%%%%%%%%%%%%%%%%%%
tH2O=0; % Do not use trace water
H2O=0.15; % Initial water content
% Starting composition
sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584; 0.0289; 0.0209; H2O;];
% Elements to include in simulation (must match above)
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
% Batch string for continuous isentropic melting
batch=['1\nsc.melts\n9\n0\n2\n0\n1\n3\n0\nolivine\northopyroxene\nclinopyroxene\nspinel\nfeldspar\nx\n7\n-1\n9\n1\n2\n0\n' num2str(Pi) '\n3\n4\n0\n'];
% Run simulation
melts=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','isentropic','continuous','','minf',0.01,'dP',-200,'Ti',potentialtemp,'Pi',Pi,'Pf',Pf);
% Notes: fO2 buffer needed when including K2O, P2O5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

toc


% Import MELTS data and calculate integrated liquid compositon
bulk=txt2mat('out1/bulk_comp_tbl.txt');
i=1; while ~(bulk(i+1,3)<bulk(i,3)); i=i+1; end % Determine point at which mass loss (melting) begins
liquid=zeros(size(bulk,1)-i, size(bulk,2)); % Make matrix to hold liquid comp.
liquid(:,1:2)=bulk(i:end-1,1:2); % Copy P and T from bulk file
liquid(:,3)=bulk(i,3)-bulk(i+1:end,3); % Calculate cumulative melt percent from mass loss
elementMasses=bsxfun(@times,bulk(i+1:end,3),bulk(i+1:end,4:end)); % element mass = mass * element percent
elementMassLost=bsxfun(@minus, bulk(i,3).*bulk(i,4:end), elementMasses);
liquid(:,4:end)=bsxfun(@rdivide, elementMassLost, liquid(:,3)); % Calculate wt percent of each element in the liquid


% Plot Temperature and percent melt against pressure
figure; plot(liquid(:,1),liquid(:,11),'r');
hold on; [ax,h1,h2]=plotyy(liquid(:,1),liquid(:,3),liquid(:,1),liquid(:,2));
xlabel('Pressure (bar)'); ylabel(ax(1),'Percent Melt'); ylabel(ax(2),'Temperature (C)'); 
if tH2O==1; title([num2str(PPMH2O) ' PPM  H2O, ' num2str(potentialtemp) ' C Tp']);
else title([num2str(H2O) ' Percent  H2O, ' num2str(potentialtemp) ' C Tp']); end


% Plot relevant elements
cols=[4,6,14,11,9,15];
c=lines(6);
figure;
for i=1:6
    hold on; plot(liquid(:,3),liquid(:,cols(i)),'Color',c(i,:))
end
legend({'SiO2','Al2O3','CaO','MgO','FeO','Na2O'});
title([num2str(H2O) ' Percent  H2O, ' num2str(potentialtemp) ' C Tp']);
