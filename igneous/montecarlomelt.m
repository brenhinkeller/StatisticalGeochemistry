%% Load melt composition  data

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
melts=rmelts(sc,elems,'fo2path','NNO','batchstring',batch,'mode','isobaric','dT',-10,'Ti',1700,'Tf',800,'Pi',Pi);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


meltdata=[melts.liquid_0.TiO2'; melts.liquid_0.Al2O3'; melts.liquid_0.Fe2O3'+melts.liquid_0.FeO'*1.111; melts.liquid_0.MgO'; melts.liquid_0.CaO'; melts.liquid_0.Na2O'; melts.liquid_0.K2O']; 
Liquid_mass=melts.liquid_0.mass;
T=melts.liquid_0.Temperature;

% % Old method (deprecated)
% load melts20kbar
% meltdata=[melts20kbar.TiO2'; melts20kbar.Al2O3'; melts20kbar.Fe2O3t'; melts20kbar.MgO'; melts20kbar.CaO'; melts20kbar.Na2O'; melts20kbar.K2O']; 
% Liquid_mass=melts20kbar.Liquid_mass;
% T=melts20kbar.T;

%% Load required variables
if ~exist('ign','var')
    load ign
end
ign.Age_Uncert=ign.Age_Max-ign.Age_Min;
ign.err.Age_Uncert=0;

% Simitems is a cell array holding the names of all the variables to
% examine. Names must be formatted as in ign.elements
simitemsin={'Age_Uncert';'Age';'SiO2';'TiO2';'Al2O3';'Fe2O3T';'MgO';'CaO';'Na2O';'K2O';};


% Construct a matrix holding all the data to be used in the simulation
uncert=zeros(size(simitemsin))';
datain=zeros(length(ign.Age),length(simitemsin));
for i=1:length(simitemsin)
    eval(sprintf('datain(:,%i)=ign.%s;', i, simitemsin{i}))
    eval(sprintf('uncert(%i)=ign.err.%s;',i,simitemsin{i}))
end
clear i


% % Create n matlab workers for parallel processing on n cores
% % Uncomment the following code as well as the parfor loop below
% % if you have matlab's Parallel Processing Toolbox installed.
% n=4;
% nn=matlabpool('size');
% if nn>0&&nn~=n
%     matlabpool close
%     matlabpool(n)
% elseif nn==0
%     matlabpool(n)
% end

%% Produce sample weights

% Range of silica values to examine
simin=43;
simax=51;

% Variables dependant on silca range
test=(ign.SiO2>simin&ign.SiO2<simax&~isnan(ign.TiO2)&~isnan(ign.Al2O3)&~isnan(ign.Fe2O3T)&~isnan(ign.CaO)&~isnan(ign.Na2O)&~isnan(ign.TiO2)&~isnan(ign.K2O)&ign.Elevation>-100);
simtitle=sprintf('%.2g-%.2g%% SiO_2',simin, simax);
printtitle=sprintf('si%g-%g',simin,simax);


% Pare down data matrix to the silica range of interest
data=datain(test,:);
% if ~exist('k','var')
    % Compute weighting coefficients
    k=invweight(ign.Latitude(test),ign.Longitude(test),ign.Age(test));
% end

% prob=1./((k./2500)+1).^2;
% prob=1./((k.*median(2./k))+1).^2;

% Compute probability keeping a given data point when sampling
prob=1./((k.*median(5./k))+1); 
% prob=1./((k.*median(2./k))+1); 


%% Run the monte carlo simulation

tic;

% Number of simulations
nsims=1000;

% Number of variables to run the simulation for
ndata=3;

% Number of age divisions
nbins=40;

% Edges of age divisions
binedges=linspace(0,4000,nbins+1)';

% Create 3-dimensional variables to hold the results
simaverages=zeros(nsims,nbins,ndata);
simerrors=zeros(nsims,nbins,ndata);
simratio=zeros(nsims,1);

% Compute age uncertainty for each sample
data(data(:,1)<10 | isnan(data(:,1)),1)=10;

% Run the simulation in parallel. Running the simulation task as a function
% avoids problems with indexing in parallelized code. Uncomment the parfor
% loop (and remove the plain for loop) if you have the Parallel Toolbox.

% parfor i=1:nsims
for i=1:nsims

    % mctask does all the hard work; simaverages and simerrors hold the results
    [simaverages(i,:,:) simerrors(i,:,:) simratio(i)]=mctaskmelt(data,prob,uncert,meltdata,Liquid_mass,T,Pi/10000,binedges,nbins);
        
end
simerrors=simerrors.*(sqrt(nanmean(simratio))+1/sqrt(nsims));

toc % Record time taken to run simulation

% Compute vector of age-bin centers for plotting
bincenters=linspace(0+2000/nbins,4000-2000/nbins,nbins)';


% Simitems holds names for the outputs of mctask that are formatted to serve as figure titles
simitemsout={'Percent Melt';'Melting Temperature';'Potential Temperature'};
% Printnames contains quivalent names formatted as valid filenames
printnames={'percentmelt';'melttemp';'potentialtemp'};





%% Plot the results

% For each item in the simulation output, create a figure with the results
i=length(simitemsout);
while i>0
    figure
    errorbar(bincenters,nanmean(simaverages(:,:,i)),2.*nanmean(simerrors(:,:,i)),'.r')
    xlabel('Age (Ma)')
    ylabel(simitemsout{i})
    title(simtitle)
    i=i-1;
end

% matlabpool close force local

%%
% % Save results
% mcmelt27k.bincenters=bincenters; mcmelt27k.simaverages=simaverages; mcmelt27k.simerrors=simerrors; mcmelt27k.simitems=simitemsout;
% save mcmelt27kign mcmelt27k
% 
% 
% %% Plot the results from saved
% 
% % For each item in the simulation output, create a figure with the results
% i=length(simitemsout);
% while i>0
%     figure
%     errorbar(mcmelt27k.bincenters,nanmean(mcmelt27k.simaverages(:,:,i)),2.*nanmean(mcmelt27k.simerrors(:,:,i)),'.r')
%     xlabel('Age (Ma)')
%     ylabel(simitemsout{i})
%     i=i-1;
% end