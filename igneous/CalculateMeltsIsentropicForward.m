%% Run adiabatic decompression melting using only selected minerals

%     % MOR-type path
%     dP = -200;
%     Ti = 1110:2:1600;
%     Pf = 1000; % Final pressure (bar)
%     Pi = linspace(Pf+1,45000,length(Ti));

    % OIB-type path
    dP = -200;
    Ti = 1270:2:1600;
    Pf = 15000; % Final pressure (bar)
    Pi = linspace(Pf+1,45000,length(Ti));
    melt = cell(length(Ti),1);
    
    for i=1:length(Ti)

        %%%%%%%%%%%%%%%%%%%%%% pMelts continuous isentropic %%%%%%%%%%%%%%%%%%%%%%%
%         H2O=0.15; % Initial water content
        H2O=0; % Zero initial water content
        % Starting composition
        sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584; 0.0289; 0.0209; H2O;]; % Primitive mantle
%         % Optional: Depleted mantle
%         if ~exist('saltersdm','var');
%             load saltersdm;
%             saltersdm = oxideConversion(saltersdm);
%             saltersdm.Fe2O3 = saltersdm.FeO/2*(55.845+1.5*16)/(55.845+16);
%             saltersdm.FeO = saltersdm.FeO/2;
%         end
%         sc = [saltersdm.SiO2; saltersdm.TiO2; saltersdm.Al2O3; saltersdm.Fe2O3; saltersdm.Cr2O3; saltersdm.FeO; saltersdm.MnO; saltersdm.MgO; saltersdm.NiO; saltersdm.CoO; saltersdm.CaO; saltersdm.Na2O; saltersdm.K2O; saltersdm.P2O5; H2O;]; % Depleted Mantle
        % Elements to include in simulation (must match above)
        elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
        % Batch string for continuous isentropic melting
        batch=['1\nsc.melts\n9\n0\n2\n0\n1\n3\n0\nolivine\northopyroxene\nclinopyroxene\nspinel\nfeldspar\nx\n7\n-1\n9\n1\n2\n0\n' num2str(Pi(i)) '\n3\n4\n0\n'];
        % Run simulation
        melt{i}=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','isentropic','continuous','','minf',0.001,'dP',-200,'Ti',Ti(i),'Pi',Pi(i),'Pf',Pf);
        % Note: fO2 buffer needed when including K2O, P2O5
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%         int.elements = {'Pressure','Temperature','mass','SiO2','TiO2','Al2O3','Fe2O3','Cr2O3','FeO','MnO','MgO','NiO','CoO','CaO','Na2O','K2O','P2O5','H2O'}; % Uncomment if using nonzero H2O
        int.elements = {'Pressure','Temperature','mass','SiO2','TiO2','Al2O3','Fe2O3','Cr2O3','FeO','MnO','MgO','NiO','CoO','CaO','Na2O','K2O','P2O5'}; % If no H2O
        int.data = load('out1/integrate.txt');
        melt{i}.liquid_0 = elementify(int);
        melt{i}.liquid_0.Temperature = melt{i}.liquid_0.Temperature - 273.15;
        melt{i}.liquid_0.mass = melt{i}.liquid_0.mass*100;
        melt{i}.PotentialTemperature = Ti(i);

        % Print results for inspection
        [melt{i}.liquid_0.Pressure/10000, melt{i}.liquid_0.Temperature, melt{i}.liquid_0.mass]
        sum(melt{i}.liquid_0.mass)
    end

    save(['adiabaticDecompressionMelting' num2str(round(Pf)) '.mat'], 'melt')

%% Run adiabatic decompression melting with unconstrained mineralogy, pre-equilibrated

    % Check near-solidus temperature
    %%%%%%%%%%%%%%%%%%%%%%% pMelts equil. batch melting %%%%%%%%%%%%%%%%%%%%%%%
    Fi = 0.04; % Position to start relative to the solidus
    H2O=0; % Initial Water
    Pi=33000; % Initial Pressure
    % Starting composition
    sc=[44.8030; 0.1991; 4.4305; 0.9778; 0.3823; 7.1350; 0.1344; 37.6345; 0.2489; 0.0129; 3.5345; 0.3584; 0.0289; 0.0209; H2O;]; %mcdbse (McDonough Pyrolite)
%     % Optional: Depleted mantle
%     if ~exist('saltersdm','var');
%         load saltersdm;
%         saltersdm = oxideConversion(saltersdm);
%         saltersdm.Fe2O3 = saltersdm.FeO/2*(55.845+1.5*16)/(55.845+16);
%         saltersdm.FeO = saltersdm.FeO/2;
%     end
%     sc = [saltersdm.SiO2; saltersdm.TiO2; saltersdm.Al2O3; saltersdm.Fe2O3; saltersdm.Cr2O3; saltersdm.FeO; saltersdm.MnO; saltersdm.MgO; saltersdm.NiO; saltersdm.CoO; saltersdm.CaO; saltersdm.Na2O; saltersdm.K2O; saltersdm.P2O5; H2O;]; % Depleted Mantle
    elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5'; 'H2O';};
    batch=['1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n' num2str(Fi) '\n0\n0\n'];
    startcomp=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','isobaric','saveall','','Pi',Pi,'Ti',1350);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    solidus = startcomp.liquid_0.Temperature


    dP = -200; % Pressure increment (bar)
    Pi = 20000:200:60000; % Inital pressure (bar)
    Pf = 20000; % Final pressure (bar)

    melt = cell(length(Pi),1);
    for i=1:length(Pi)
        dP = max(round((Pf-Pi(i))/20),-500);

        %%%%%%%%%%%%%%%% pMelts continuous P-T path melting %%%%%%%%%%%%%%%%%%%
        % Batch string
        batch=['1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n' num2str(Fi) '\n0\n10\n0\n4\n0\n'];
        % Run simulation
        melt{i}=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','isentropic','continuous','','minf',0.015,'dP',dP,'Pi',Pi(i),'Pf',Pf,'Ti',solidus);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%         int.elements = {'Pressure','Temperature','mass','SiO2','TiO2','Al2O3','Fe2O3','Cr2O3','FeO','MnO','MgO','NiO','CoO','CaO','Na2O','K2O','P2O5','H2O'}; % Uncomment if using H2O
        int.elements = {'Pressure','Temperature','mass','SiO2','TiO2','Al2O3','Fe2O3','Cr2O3','FeO','MnO','MgO','NiO','CoO','CaO','Na2O','K2O','P2O5'}; % If no H2O
        int.data = load('out1/integrate.txt');
        melt{i}.liquid_0 = elementify(int);
        melt{i}.liquid_0.Temperature = melt{i}.liquid_0.Temperature - 273.15; % Integrate file doesn't follow celcius output.
        melt{i}.liquid_0.mass = melt{i}.liquid_0.mass*100;

        % Print results for inspection
         [melt{i}.liquid_0.Pressure/10000, melt{i}.liquid_0.Temperature, melt{i}.liquid_0.mass]
        sum(melt{i}.liquid_0.mass)
    end

    save(['adiabaticDecompressionMelting' num2str(round(Pf)) '.mat'], 'melt')

%% Calculate cumulative melt composition
% Calculate cumulative melt composition for each polybaric simulation
elems={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Cr2O3';'FeO';  'MnO';  'MgO';   'NiO';  'CoO';  'CaO';  'Na2O'; 'K2O'; 'P2O5';};

melts = struct;
melts.liquid_0.Pressure = cellfun(@(x) x.liquid_0.Pressure(end), melt);
melts.liquid_0.Temperature = cellfun(@(x) x.liquid_0.Temperature(end), melt);
melts.liquid_0.PotentialTemperature = cellfun(@(x) x.PotentialTemperature, melt);
melts.liquid_0.mass = cellfun(@(x) sum(x.liquid_0.mass), melt);

melts.liquid_0.mass(melts.liquid_0.Pressure>(Pf+1009)) = NaN;
melts.liquid_0.mass(melts.liquid_0.mass==0) = NaN;
[~,i,~] = unique(melts.liquid_0.mass);
i = i(~isnan(melts.liquid_0.mass(i)));
for e = elems';
    melts.liquid_0.(e{:}) = cellfun(@(x) sum(x.liquid_0.mass .* x.liquid_0.(e{:}))./sum(x.liquid_0.mass), melt);
end

for e = [elems','Temperature','Pressure'];
    melts.liquid_0.(e{:}) = interp1(melts.liquid_0.mass(i),melts.liquid_0.(e{:})(i),(1:1:100)');
end
melts.liquid_0.mass = (1:1:100)';

% Plot melt evolution
figure; plot(melts.liquid_0.Temperature(1:end-6),melts.liquid_0.mass(1:end-6))
xlabel('Temperature (C)'); ylabel('Percent Melt');

figure;
 for e = elems';
     hold on; plot(melts.liquid_0.mass, melts.liquid_0.(e{:}));
 end
legend(elems)
xlabel('Percent melt'); ylabel('Wt. %');