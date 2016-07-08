% Montecarlo.m
% Run a full monte carlo simulation
% Each actual simulation task is conducted by mctask.m, this code provides
% the data needed for mctask to work and stores the results Any variables 
% needed during the simulation must exist in simitemsin; these variables
% will be read into data, filtered, and passed to mctask.
%% Load required variables
load ign

% Simitems is a cell array holding the names of all the variables to
% examine. Names must be formatted as in ign.elements
simitemsin={'SiO2';'TiO2';'Al2O3';'FeOT';'MgO';'CaO';'MnO';'Na2O';'K2O';'P2O5';'Cr';'Co';'Ni';'La';'Ce';'Pr';'Nd';'Sm';'Eu';'Gd';'Tb';'Dy';'Ho';'Er';'Tm';'Yb';'Lu';'Y';'Sc';'V';'Zr';'Hf';'Rb';'Sr';'Ba';'Nb';'Ta';'U';'Th';};

% See what the age of each sample is; this will be our independent variable
age_uncert_min = 50; % Set minimum age uncertainty (analagous to kernel width)
ages = ign.Age;
age_uncert = ign.Age_Max - ign.Age_Min;
age_uncert(age_uncert<age_uncert_min | isnan(age_uncert)) = age_uncert_min;

% Construct a matrix holding all the data to be used in the simulation
uncert=zeros(1,length(simitemsin)+2);
data=zeros(length(ign.Age),length(simitemsin)+2);
data(:,1) = age_uncert; % Independent variable uncert goes in position one
data(:,2) = ages; % Independent variable values go in position two
for i=1:length(simitemsin)
    data(:,i+2)=ign.(simitemsin{i});
    uncert(i+2)=ign.err.(simitemsin{i});
end



%% Produce sample weights for bootstrap resamplingaaa

% Range of silica and age values to examine
simin=43;
simax=51;
agemin=0;
agemax=4000;

% Reject data that is out of the range of interest, is all NANs, or isn't from a contienent
test=(ign.SiO2>simin &ign.SiO2<simax &ign.Age>agemin&ign.Age<agemax &~any(isnan(data(:,1:2)),2) &any(~isnan(data(:,4:end)),2) &ign.Elevation>-100 &~ign.oibs); 
data=data(test,:);

% Compute weighting coefficients
k=invweight(ign.Latitude(test),ign.Longitude(test),ign.Age(test));

% Compute probability keeping a given data point when sampling
prob=1./((k.*median(5./k))+1); % Keep rougly one-fith of the data in each resampling

% What to call the simulation results
simtitle=sprintf('%.2g-%.2g%% SiO_2',simin, simax);
savetitle=sprintf('mc%g%g',simin,simax);

%% Run the monte carlo simulation and bootstrap resampling

tic;

% Number of simulations
nsims=10000;

% Number of variables to run the simulation for
ndata=length(simitemsin);

% Number of age divisions
nbins=40;

% Edges of age divisions
binedges=linspace(agemin,agemax,nbins+1)';

% Create 3-dimensional variables to hold the results
simaverages=zeros(nsims,nbins,ndata);
simerrors=zeros(nsims,nbins,ndata);
simratio=zeros(nsims,1);


% Run the simulation in parallel. Running the simulation task as a function
% avoids problems with indexing in parallelized code.
gcp; %Start a parellel processing pool if there isn't one already
parfor i=1:nsims
    
    % mctask does all the hard work; simaverages and simerrors hold the results
    [simaverages(i,:,:), simerrors(i,:,:), simratio(i)]=mctask(data,prob,uncert,binedges,nbins);
        
end
% Names of output variables
simitemsout = simitemsin; % This would not be true if we were to perform calculations (e.g. ratios, etc) on the input variables in mctest

% Adjust uncertaintites such that as nsims approaches infinity, the
% uncertainties approach sigma/sqrt(N) where N is the number of original
% real data points.
simerrors=simerrors.*(sqrt(nanmean(simratio))+1/sqrt(nsims));

toc % Record time taken to run simulation

% Compute vector of age-bin centers for plotting
bincenters=linspace(0+(agemax-agemin)/2/nbins,agemax-(agemax-agemin)/2/nbins,nbins)';



%% Plot the results

% For each item in the simulation output, create a figure with the results
i=length(simitemsout);
while i>0
    figure
    errorbar(bincenters(1:end-1),nanmean(simaverages(:,1:end-1,i)),2.*nanmean(simerrors(:,1:end-1,i)),'.r')
    xlabel('Age (Ma)')
    ylabel(simitemsout{i})
    title(simtitle)
%     formatfigure
    i=i-1;
end

%% Print results to csv files

% i=length(simitemsout);
% averages = NaN(39,length(simitemsout)+1);
% uncertainties = NaN(39,length(simitemsout)+1);
% averages(:,1)=bincenters(1:39);
% uncertainties(:,1)=bincenters(1:39);
% for i=1:length(simitemsout)
%     averages(:,i+1) = nanmean(simaverages(:,1:end-1,i))';
%     uncertainties(:,i+1) = nanmean(simerrors(:,1:end-1,i))';
% end
% exportmatrix(averages,'averages.csv',',');
% exportmatrix(uncertainties,'uncertainties.csv',',');

%% Save results

% eval([savetitle '.bincenters=bincenters;']); eval([savetitle '.simaverages=simaverages;']); eval([savetitle '.simerrors=simerrors;']); eval([savetitle '.simitems=printnames;']);
% for i=1:length(printnames)
%     eval([savetitle '.' printnames{i} '=simaverages(:,:,' num2str(i) ');'])
%     eval([savetitle '.' printnames{i} '_err=simerrors(:,:,' num2str(i) ');'])
% end
% eval(['save ' savetitle ' ' savetitle]);
