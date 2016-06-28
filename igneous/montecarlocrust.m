%% Load required variables
load ign

% Simitems is a cell array holding the names of all the variables to
% examine. Names must be formatted as in ign.elements
simitemsin={'Age_Uncert';'Age';'Crust';'tc1Lith';};
ign.Age_Uncert = abs(ign.Age_Max-ign.Age_Min);

% Construct a matrix holding all the data to be used in the simulation
uncert=zeros(size(simitemsin))';
datain=zeros(length(ign.Age),length(simitemsin));
for i=1:length(simitemsin)
    eval(sprintf('datain(:,%i)=ign.%s;', i, simitemsin{i}))
    eval(sprintf('uncert(%i)=ign.err.%s;',i,simitemsin{i}))
end
clear i


% % Create n matlab workers for parallel processing on n cores
% n=2;
% matlabpool(n)

%% Produce sample weights

% Range of silica values to examine
simin=43;
simax=74;

% test=(((ign.SiO2>43&ign.SiO2<52)|(ign.SiO2>62&ign.SiO2<74))&~ign.badpoints&ign.onland);
ign=findOIBs(ign);
test=(((ign.SiO2>43&ign.SiO2<52)|(ign.SiO2>62&ign.SiO2<74))&~ign.oibs&ign.Elevation>-100);
simtitle=sprintf('%.2g-%.2g%% SiO_2',simin, simax);
printtitle=sprintf('si%g-%g',simin,simax);
savetitle=sprintf('mc%g%g',simin,simax);

% Pare down data matrix to the silica range of interest
data=datain(test,:);

% Compute weighting coefficients
k=invweight(ign.Latitude(test),ign.Longitude(test),ign.Age(test));

% Compute probability keeping a given data point when sampling
prob=1./((k.*median(5./k))+1); 


%% Run the monte carlo simulation

tic;

% Number of simulations
nsims=10000;

% Number of variables to run the simulation for
ndata=2;

% Number of age divisions
nbins=40;

% Edges of age divisions
binedges=linspace(0,4000,nbins+1)';

% Create 3-dimensional variables to hold the results
simaverages=zeros(nsims,nbins,ndata);
simerrors=zeros(nsims,nbins,ndata);
simratio=zeros(nsims,1);

% Set minimum age uncertainty for each sample
data(data(:,1)<10 | isnan(data(:,1)),1)=10;

% Run the simulation in parallel. Running the simulation task as a function
% avoids problems with indexing in parallelized code.
% parfor i=1:nsims
for i=1:nsims
    
    % mctask does all the hard work; simaverages and simerrors hold the results
    [simaverages(i,:,:) simerrors(i,:,:) simratio(i)]=mctaskcrust(data,prob,uncert,binedges,nbins);
        
end
simerrors=simerrors.*(sqrt(nanmean(simratio))+1/sqrt(nsims));

toc % Record time taken to run simulation

% Compute vector of age-bin centers for plottinpg
bincenters=linspace(0+2000/nbins,4000-2000/nbins,nbins)';


% Simitems holds names for the outputs of mctask that are formatted to serve as figure titles
simitemsout={'Present-Day Crustal Thickness';'Lithospheric Thickness';};
% Printnames contains quivalent names formatted as valid filenames
printnames={'Crust';'tc1Lith';};





%% Plot the results

% For each item in the simulation output, create a figure with the results
i=length(simitemsout);
while i>0
    figure
    errorbar(bincenters,nanmean(simaverages(:,:,i)),2.*nanmean(simerrors(:,:,i)),'.r')
    xlabel('Age (Ma)')
    ylabel(simitemsout{i})
    title(simtitle)
%     formatfigure
%     saveas(gcf,[printtitle ' ' printnames{i} '.png'],'png')
%     saveas(gcf,[printtitle ' ' printnames{i} '.fig'],'fig')
%     saveas(gcf,[printtitle ' ' printnames{i} '.eps'],'epsc')
    i=i-1;
end


% matlabpool close

%%
% Save results
eval([savetitle '.bincenters=bincenters;']); eval([savetitle '.simaverages=simaverages;']); eval([savetitle '.simerrors=simerrors;']); eval([savetitle '.simitems=printnames;']);
for i=1:length(printnames)
    eval([savetitle '.' printnames{i} '=simaverages(:,:,' num2str(i) ');'])
    eval([savetitle '.' printnames{i} '_err=simerrors(:,:,' num2str(i) ');'])
end
eval(['save ' savetitle ' ' savetitle]);
