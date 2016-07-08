%% Run range of melt simulations at pressures betwen between Pi and Pf
Pi = 10000; % Start of pressure range (bar)
Pf = 30000; % End of pressure range (bar)
H2Oi = 1; % Initial mantle Water content (%)
fo2path = 'FMQ';
nsims=8; % Number of simulations to run

% Batch string for alphamelts
batch='1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n1.0\n0\n10\n0\n4\n0\n'; % Equilibrium batch melting.

% Run simulations
melts=cell(nsims,1);
for n=1:nsims
    % Vary some variable of interest
    P=Pi+(Pf-Pi)/nsims*n;
    H2O=H2Oi;
    
    %%%%%%%%%%%%%%%%%%%%%%% pMelts equil. batch melting %%%%%%%%%%%%%%%%%%%%%%%
    % Elements to include in simulation (must match starting composition)
    elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
    % Starting composition
    sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584; 0.0289; 0.0209; H2O;]; %mcdbse (McDonough Pyrolite)
    % Run simulation
    melts{n}=rmelts(sc,elems,'fo2path',fo2path,'batchstring',batch,'mode','isobaric','dT',-10,'Ti',1700,'Tf',800,'Pi',P,'simnumber',n,'version','pMELTS');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end


%%
figure
%% Plot results for full range of melt percentages
xelem = 'SiO2'; % Element for x axis
yelem = 'MgO'; % Element for y axis

h = zeros(nsims,1);
l = cell(nsims,1);
hold on;
for n=1:nsims
    h(n) = plot(melts{n}.liquid_0.(xelem),melts{n}.liquid_0.(yelem),'Color',[0,0,1-n/nsims/2]);
    l{n} = [num2str(melts{n}.liquid_0.Pressure(1)) ' bar'];
end
legend(h, l);

%% Plot results for a constant melt percentage
percentmelt = 15;
xelem = 'SiO2';
yelem = 'MgO';

h = zeros(nsims,1);
l = cell(nsims,1);
hold on;
for n=1:nsims
    [~,i]=min(abs(melts{1}.liquid_0.mass-percentmelt));
    h(n) = plot(melts{n}.liquid_0.(xelem)(i),melts{n}.liquid_0.(yelem)(i),'.','MarkerSize',20,'Color',[0,0,1-n/nsims/2]);
    l{n} = [num2str(melts{n}.liquid_0.Pressure(1)) ' bar'];
end
legend(h, l);

%%
figure
%% Plot results for a fraction for full range of melt percentages
xelem = 'MgO';
num = 'CaO'; % Numerator
den = 'Al2O3'; % Denominator

h = zeros(nsims,1);
l = cell(nsims,1);
hold on;
for n=1:nsims
    h(n) = plot(melts{n}.liquid_0.(xelem),melts{n}.liquid_0.(num)./melts{n}.liquid_0.(den),'Color',[n/nsims,0,1-n/nsims]);
    l{n} = [num2str(melts{n}.liquid_0.Pressure(1)) ' GPa'];
end
legend(h, l);

%% Plot results for a fraction at a constant melt percentage
percentmelt = 10;
xelem = 'MgO';
num = 'CaO';
den = 'Al2O3';

h = zeros(nsims,1);
l = cell(nsims,1);
hold on;
for n=1:nsims
    [~,i]=min(abs(melts{1}.liquid_0.mass-percentmelt));
    h(n) = plot(melts{n}.liquid_0.(xelem)(i),melts{n}.liquid_0.(num)(i)./melts{n}.liquid_0.(den)(i),'.','MarkerSize',20,'Color',[n/nsims,0,1-n/nsims]);
    l{n} = [num2str(melts{n}.liquid_0.Pressure(1)) ' GPa'];
end
legend(h, l);

