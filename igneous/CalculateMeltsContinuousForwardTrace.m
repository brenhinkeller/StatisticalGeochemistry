%% Run polybaric decompression melting from 3.3-2kbar (arc-type path)

    initialPressure = 33000;
    finalPressure = 20000;

    % Check near-solidus (0.1% melt) temperature
    %%%%%%%%%%%%%%%%%%%%%%% pMelts equil. batch melting %%%%%%%%%%%%%%%%%%%%%%%
    Fi = 0.01; % Position to start relative to the solidus
    H2O=0.2; % Initial Water
    Pi=initialPressure; % Initial Pressure
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

    dT = 5;
    Tf = 1265:dT:1675;

    melt = cell(length(Tf),1);
    for i=1:length(Tf)
        %%%%%%%%%%%%%%%% pMelts continuous P-T path melting %%%%%%%%%%%%%%%%%%%
        Ti = Tf(i)-1;
        dP = (finalPressure-initialPressure)/floor((Tf(i)-solidus)/dT);
        % Batch string
        batch=['1\nsc.melts\n10\n1\n3\n1\nliquid\n1\n' num2str(Fi) '\n0\n10\n0\n4\n0\n'];
        % Run simulation
        melt{i}=rmelts(sc,elems,'fo2path','FMQ','batchstring',batch,'mode','geothermal','continuous','','dT',dT,'dP',dP,'Ti',Ti,'Tf',Tf(i),'Pi',Pi);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        int.elements = {'Pressure','Temperature','mass','SiO2','TiO2','Al2O3','Fe2O3','Cr2O3','FeO','MnO','MgO','NiO','CoO','CaO','Na2O','K2O','P2O5','H2O'};
        int.data = load('out1/integrate.txt');
        melt{i}.liquid_0 = elementify(int);
        melt{i}.liquid_0.Temperature = melt{i}.liquid_0.Temperature - 273.15;
        melt{i}.liquid_0.mass = melt{i}.liquid_0.mass*100;

        % Print results for inspection
        [melt{i}.liquid_0.Pressure/10000, melt{i}.liquid_0.Temperature, melt{i}.liquid_0.mass, melt{i}.liquid_0.H2O]
        sum(melt{i}.liquid_0.mass)
    end

%% Parse results to find masses
    mass = cell(length(melt),1);
    for j = 1:length(melt)    
        % Determine minimum and maximum temperature in the simulation
        minT=NaN;
        maxT=NaN;
        for i=1:length(melt{j}.minerals)
            maxT=max([maxT max(melt{j}.(melt{j}.minerals{i}).Temperature)]);
            minT=min([minT min(melt{j}.(melt{j}.minerals{i}).Temperature)]);
        end

        % Determine temperature step
        if range(melt{j}.liquid_0.Temperature(1:end-1)-melt{j}.liquid_0.Temperature(2:end))<10^-5
            deltaT=abs(melt{j}.liquid_0.Temperature(1)-melt{j}.liquid_0.Temperature(2));
            simlength=round((maxT-minT)./deltaT)+1;
        else
            error('Non-uniform temperature step');
        end

        % Calculate individual components for feldspar and oxides
        An_Ca=(220.1298+56.18)/56.18;
        Ab_Na=(228.2335+30.99)/30.99;
        Or_K=(228.2335+47.1)/47.1;
        for i=1:length(melt{j}.minerals)
            if ~isempty(strfind(lower(melt{j}.minerals{i}),'feldspar')) && ~isfield(melt{j}, 'anorthite')
                feldsparComp=bsxfun(@rdivide, [melt{j}.(melt{j}.minerals{i}).CaO*An_Ca melt{j}.(melt{j}.minerals{i}).Na2O*Ab_Na melt{j}.(melt{j}.minerals{i}).K2O*Or_K], (melt{j}.(melt{j}.minerals{i}).CaO*An_Ca + melt{j}.(melt{j}.minerals{i}).Na2O*Ab_Na + melt{j}.(melt{j}.minerals{i}).K2O*Or_K));
                melt{j}.(['anorthite' melt{j}.minerals{i}(9:end)]).mass=melt{j}.(melt{j}.minerals{i}).mass.*feldsparComp(:,1);
                melt{j}.(['anorthite' melt{j}.minerals{i}(9:end)]).Temperature=melt{j}.(melt{j}.minerals{i}).Temperature;
                melt{j}.(['albite' melt{j}.minerals{i}(9:end)]).mass=melt{j}.(melt{j}.minerals{i}).mass.*feldsparComp(:,2);
                melt{j}.(['albite' melt{j}.minerals{i}(9:end)]).Temperature=melt{j}.(melt{j}.minerals{i}).Temperature;
                melt{j}.(['orthoclase' melt{j}.minerals{i}(9:end)]).mass=melt{j}.(melt{j}.minerals{i}).mass.*feldsparComp(:,3);
                melt{j}.(['orthoclase' melt{j}.minerals{i}(9:end)]).Temperature=melt{j}.(melt{j}.minerals{i}).Temperature;
                melt{j}.minerals=unique([melt{j}.minerals; ['anorthite' melt{j}.minerals{i}(9:end)]; ['albite' melt{j}.minerals{i}(9:end)]; ['orthoclase' melt{j}.minerals{i}(9:end)];],'stable');
            elseif ~isempty(strfind(lower(melt{j}.minerals{i}),'rhm_oxide'))
                if isfield(melt{j}.(melt{j}.minerals{i}),'MnO')
                    Ilmenite=(melt{j}.(melt{j}.minerals{i}).TiO2+melt{j}.(melt{j}.minerals{i}).MnO+(melt{j}.(melt{j}.minerals{i}).TiO2*(71.8444/79.8768)-melt{j}.(melt{j}.minerals{i}).MnO*(71.8444/70.9374)))/100;
                    Magnetite=(melt{j}.(melt{j}.minerals{i}).FeO-(melt{j}.(melt{j}.minerals{i}).TiO2)*71.8444/79.8768)*(1+159.6882/71.8444)/100;
                else
                    Ilmenite=(melt{j}.(melt{j}.minerals{i}).TiO2 + melt{j}.(melt{j}.minerals{i}).TiO2*71.8444/79.8768)/100;
                    Magnetite=(melt{j}.(melt{j}.minerals{i}).FeO-melt{j}.(melt{j}.minerals{i}).TiO2*71.8444/79.8768)*(1+159.6882/71.8444)/100;
                end
                Magnetite(Magnetite<0)=0;
                Hematite=(melt{j}.(melt{j}.minerals{i}).Fe2O3-Magnetite*100*159.6882/231.5326)/100;
                melt{j}.(['ilmenite' melt{j}.minerals{i}(9:end)]).mass=melt{j}.(melt{j}.minerals{i}).mass.*Ilmenite;
                melt{j}.(['ilmenite' melt{j}.minerals{i}(9:end)]).Temperature=melt{j}.(melt{j}.minerals{i}).Temperature;
                melt{j}.(['magnetite' melt{j}.minerals{i}(9:end)]).mass=melt{j}.(melt{j}.minerals{i}).mass.*Magnetite;
                melt{j}.(['magnetite' melt{j}.minerals{i}(9:end)]).Temperature=melt{j}.(melt{j}.minerals{i}).Temperature;
                melt{j}.(['hematite' melt{j}.minerals{i}(9:end)]).mass=melt{j}.(melt{j}.minerals{i}).mass.*Hematite;
                melt{j}.(['hematite' melt{j}.minerals{i}(9:end)]).Temperature=melt{j}.(melt{j}.minerals{i}).Temperature;
                melt{j}.minerals=unique([melt{j}.minerals; ['ilmenite' melt{j}.minerals{i}(9:end)]; ['magnetite' melt{j}.minerals{i}(9:end)]; ['hematite' melt{j}.minerals{i}(9:end)];],'stable');
            end
        end


        % Make a new struct containing zero-extended mineral masses
        mass{j}=struct;
        mass{j}.minerals=melt{j}.minerals;
        mass{j}.solids=zeros(simlength,1);
        for i=1:length(melt{j}.minerals)
            melt{j}.(melt{j}.minerals{i}).Index=round((melt{j}.(melt{j}.minerals{i}).Temperature-minT)./deltaT)+1;
            mass{j}.(melt{j}.minerals{i})=zeros(simlength,1);
            mass{j}.(melt{j}.minerals{i})(melt{j}.(melt{j}.minerals{i}).Index)=melt{j}.(melt{j}.minerals{i}).mass;
            if isempty(strfind(melt{j}.minerals{i},'liquid')) && isempty(strfind(melt{j}.minerals{i},'water')) && isempty(strfind(melt{j}.minerals{i},'rhmoxide')) && isempty(strfind(melt{j}.minerals{i},'feldspar'))
                mass{j}.solids=mass{j}.solids+mass{j}.(melt{j}.minerals{i});
            end
        end

        % Total liquid mass
        mass{j}.liquids = 100-mass{j}.solids;

        % Recalculate differential liquid mass; Melts seems to report
        % untrustworth values
        mass{j}.liquid_0 = mass{j}.liquids - [0; mass{j}.liquids(1:end-1)];
        if(length(mass{j}.liquid_0) == length(melt{j}.liquid_0.mass))
            melt{j}.liquid_0.mass = mass{j}.liquid_0;
        else
            warning('Liquid may not be present for entire simulation\n') 
        end
    end

%% Calculate cumulative melt composition
    % Calculate cumulative melt composition for each polybaric simulation
    melts = struct;
    melts.liquid_0.Pressure = cellfun(@(x) x.liquid_0.Pressure(end), melt);
    melts.liquid_0.Temperature = cellfun(@(x) x.liquid_0.Temperature(end), melt);
    melts.liquid_0.InitialTemperature = cellfun(@(x) x.liquid_0.Temperature(1), melt);
    melts.liquid_0.InitialPressure = cellfun(@(x) x.liquid_0.Pressure(1), melt);
    melts.liquid_0.PotentialTemperature = potentialtemperature(melts.liquid_0.InitialTemperature+273.15,melts.liquid_0.InitialPressure)-273.15;
    melts.liquid_0.mass = cellfun(@(x) sum(x.liquid_0.mass), melt);
    for e = elems';
        melts.liquid_0.(e{:}) = cellfun(@(x) sum(x.liquid_0.mass .* x.liquid_0.(e{:}))./sum(x.liquid_0.mass), melt);
    end


    % As above, but append very low percent melt results from beginning of
    % first simulation so that we can get the results for temperatures below
    % 1265 (MELTS seems to crash if we use end temperatures below 1265)
    % melts = struct;
    % melts.liquid_0.Pressure = [melt{1}.liquid_0.Pressure(1:end-1); cellfun(@(x) x.liquid_0.Pressure(end), melt)];
    % melts.liquid_0.Temperature = [melt{1}.liquid_0.Temperature(1:end-1); cellfun(@(x) x.liquid_0.Temperature(end), melt)];
    % melts.liquid_0.mass = [cumsum(melt{1}.liquid_0.mass(1:end-1)); cellfun(@(x) sum(x.liquid_0.mass), melt)];
    % for e = elems';
    %     melts.liquid_0.(e{:}) = [cumsum(melt{1}.liquid_0.mass(1:end-1) .* melt{1}.liquid_0.(e{:})(1:end-1)) ./ cumsum(melt{1}.liquid_0.mass(1:end-1)); cellfun(@(x) sum(x.liquid_0.mass .* x.liquid_0.(e{:}))./sum(x.liquid_0.mass), melt)];
    % end

    % melts.liquid_0.sum = zeros(size(melts.liquid_0.mass));
    % for e = elems';
    %     melts.liquid_0.sum = melts.liquid_0.sum + melts.liquid_0.(e{:});
    % end
%% Plot melt evolution
    figure; plot(melts.liquid_0.Temperature(1:end-6),melts.liquid_0.mass(1:end-6))
    xlabel('Temperature (C)'); ylabel('Percent Melt');

    figure;
     for e = elems';
         hold on; plot(melts.liquid_0.mass, melts.liquid_0.(e{:}));
     end
    legend(elems)
    xlabel('Percent melt'); ylabel('Wt. %');

    figure; plot(melts.liquid_0.mass,melts.liquid_0.H2O)
    xlabel('Percent Melt'); ylabel('H2O');

%% Trace element calculations
    traceelements={'La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Sc','V','Cr','Co','Ni','Cu','Zn','Ga','Zr','Rb','Ba','Y','Pb','Nb','Sr','Ta','Mo','U','Cs','W','Th','Hf'};
    % traceelements={'Rb','Ba','Th','U','K','Nb','Ta','La','Ce','Pb','Nd','Sr','Sm','Zr','Eu','Gd','Ti','Dy','Y','Er','Yb','Lu'}; % Elliott Elements
    % traceelements={'Cs','Rb','K','Ba','Sr','La','Sm','Tb','Y','Yb','Nb'}; % Tatsumi elements
    % traceelements={'Rb','K','Na','Li','Ba','Sr'}; %Mobile elements
    % traceelements={'Hf','Zr','Ti','Ta','Nb'}; % Nonmobile elements
    load partitioncoeffs
    load mcdbse

    for j = 1:length(melt)
        index=melt{j}.liquid_0.Index;
        meltSiInd=round(melt{j}.liquid_0.SiO2)-39;
        meltSiInd(meltSiInd<1)=1;

        for elem=traceelements;
            % Calculate bulk partition coeff.
            D.(elem{:})=zeros(size(index));
            for i=1:length(p.minerals)
                mnrlindxs=find(~cellfun('isempty',strfind(melt{j}.minerals, lower(p.minerals{i}))));
                for k=1:length(mnrlindxs)
                    % Note that minerals that we don't have data for end up being
                    % treated like all elements are incompatible in them.
                    % Note, geometric mean = log average
                    D.(elem{:})=nansum([D.(elem{:}) mass{j}.(mass{j}.minerals{mnrlindxs(k)})(index)./mass{j}.solids(index) .* (10.^p.(p.minerals{i}).(elem{:})(meltSiInd)) ],2);
                end
            end 
            melts.D.(elem{:})(j) = D.(elem{:})(end);
        end

        F=mass{j}.liquid_0./mass{j}.solids;

        % Calculate trace elements as a function of melt fraction
        for elem=traceelements;
            melt{j}.liquid_0.(elem{:}) = NaN(size(F));
            melt{j}.solid.(elem{:}) = NaN(size(F));

            melt{j}.liquid_0.(elem{:})(1) = 1*mcdbse.(elem{:}) ./ (D.(elem{:})(1) .* (1-F(1))+F(1)); 
            melt{j}.solid.(elem{:})(1) = (1*mcdbse.(elem{:})*100 - melt{j}.liquid_0.(elem{:})(1)*mass{j}.liquid_0(1)) / mass{j}.solids(1);
            for i = 2:length(F)
                melt{j}.liquid_0.(elem{:})(i) = melt{j}.solid.(elem{:})(i-1) ./ (D.(elem{:})(i) .* (1-F(i))+F(i));
                melt{j}.solid.(elem{:})(i) = (melt{j}.solid.(elem{:})(i-1)*mass{j}.solids(i-1) - melt{j}.liquid_0.(elem{:})(i)*mass{j}.liquid_0(i)) / mass{j}.solids(i);
            end
        end
    end

    % Calculate accumulated melt composition 
    for e = traceelements;
        melts.liquid_0.(e{:}) = cellfun(@(x) sum(x.liquid_0.mass .* x.liquid_0.(e{:}))./sum(x.liquid_0.mass), melt);
    end

    % Plot results
    figure;
    for e = traceelements;
        hold on; plot(melts.liquid_0.mass, melts.liquid_0.(e{:}));
    end
    set(gca,'yscale','log')
    legend(traceelements)
    xlabel('Percent melt'); ylabel('PPM');

