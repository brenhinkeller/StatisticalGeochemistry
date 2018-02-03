%% Load data
if ~exist('mcigne','var'); load mcigne; end % N.B. this variable must be generated using mctest.m: it is too big to store on GitHub 
load YlCn % Colormap

% Names of variables that we want to produce a covariance matrix for

% Standard: plotitems={'SiO2','K2O','Rb','Th','U','Pb','Cs','Li','Na2O','Ba','Sr','La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Y','Hf','Zr','Ta','Nb','Ga','Zn','TiO2','MnO','Sc','V','FeO','CaO','Co','MgO','Ni','Cu','Cr2O3'};

% Extended: plotitems={'SiO2','K2O','Rb','Th','U','Pb','Tl','Cs','Li','Na2O','Al2O3','Ba','Sr','La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Y','Hf','Zr','Ta','Nb','F','Ga','Sn','As','Sb','S','Se','Te','Ag','Cd','Zn','P2O5','TiO2','MnO','Sc','V','FeO','CaO','Co','MgO','Ni','Cu','Cr2O3'};

% Symmetric: 
plotitems={'SiO2','K2O','Rb','Th','U','Pb','Tl','Cs','Li','Na2O','Al2O3','Ba','Sr','La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Y','Hf','Zr','Ta','Nb','F','Ga','Sn','Cd','Zn','P2O5','TiO2','MnO','Sc','V','FeO','CaO','Co','MgO','Ni','Cr2O3'};

% Fill a matrix with the variables of interest
data = NaN(length(mcigne.SiO2),length(plotitems));
for i=1:length(plotitems)
    data(:,i) = mcigne.(plotitems{i});
end


%% Make a pairwise covariance matrix, ignoring NaNs
covmat=zeros(length(data(1,:)));

for i=1:length(data(1,:))
   for j=1:i
       a=data(:,i);
       b=data(:,j);
       c=~isnan(a+b);
       if sum(c)>3
           covmat(i,j)=corr(a(c),b(c));
       else
           covmat(i,j)=0;
       end
       covmat(j,i)=covmat(i,j);
   end
end


%% Plot the covariance matrix
figure
imagesc(covmat,[-0.8,1]);

set(gca,'YTick',1:1:length(plotitems))
set(gca,'YTickLabel', {plotitems{1:end}})
set(gca,'XAxisLocation','top')
set(gca,'XTickLabelRotation',90)
set(gca,'XTick',1:1:length(plotitems))
set(gca,'XTickLabel', {plotitems{1:end}})
colormap(YlCn)

%% Compare and plot covarinace of Archean vs Phanerozoic samples

% Archean first
atest = mcigne.Age > 2500; % & (isnan(mcigne.Ta) | mcigne.Ta<9 | mcigne.Ta > 11); %% Ignore anomalous Papunen Ta data with Ta=10
data = NaN(length(mcigne.SiO2(atest)),length(plotitems));
for i=1:length(plotitems)
    data(:,i) = mcigne.(plotitems{i})(atest);
end
acovmat=zeros(length(data(1,:)));
for i=1:length(data(1,:))
   for j=1:i
       a=data(:,i);
       b=data(:,j);
       c=~isnan(a+b);
       if sum(c)>3
           acovmat(i,j)=corr(a(c),b(c));
       else
           acovmat(i,j)=0;
       end
       acovmat(j,i)=acovmat(i,j);
   end
end

% Then Phanerozoic
ptest = mcigne.Age < 541;
data = NaN(length(mcigne.SiO2(ptest)),length(plotitems));
for i=1:length(plotitems)
    data(:,i) = mcigne.(plotitems{i})(ptest);
end
pcovmat=zeros(length(data(1,:)));
for i=1:length(data(1,:))
   for j=1:i
       a=data(:,i);
       b=data(:,j);
       c=~isnan(a+b);
       if sum(c)>3
           pcovmat(i,j)=corr(a(c),b(c));
       else
           pcovmat(i,j)=0;
       end
       pcovmat(j,i)=pcovmat(i,j);
   end
end

covmat = acovmat-pcovmat;

figure; imagesc(covmat,[-0.5,0.5]);
set(gca,'YTick',1:1:length(plotitems))
set(gca,'YTickLabel', plotitems(1:end))
set(gca,'XAxisLocation','top')
set(gca,'XTickLabelRotation',90)
set(gca,'XTick',1:1:length(plotitems))
set(gca,'XTickLabel', plotitems(1:end))
colormap(YlCn);
