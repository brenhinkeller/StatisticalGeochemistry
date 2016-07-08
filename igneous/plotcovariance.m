%% Load data
% Name of struct
name='ign';
if ~exist(name,'var')
    load(name)
end

% Names of fields of struct that you want to make a covariance matrix for:

% Standard:
% plotitems={'SiO2','K2O','Rb','Th','U','Pb','Cs','Li','Na2O','Ba','Sr','La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Y','Hf','Zr','Ta','Nb','Ga','Zn','TiO2','MnO','Sc','V','FeO','CaO','Co','MgO','Ni','Cu','Cr2O3'};

% Extended:
% plotitems={'SiO2','K2O','Rb','Th','U','Pb','Tl','Cs','Li','Na2O','Al2O3','Ba','Sr','La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Y','Hf','Zr','Ta','Nb','F','Ga','Sn','As','Sb','S','Se','Te','Ag','Cd','Zn','P2O5','TiO2','MnO','Sc','V','FeO','CaO','Co','MgO','Ni','Cu','Cr2O3'};

% Symmetric
plotitems={'SiO2','K2O','Rb','Th','U','Pb','Tl','Cs','Li','Na2O','Al2O3','Ba','Sr','La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Y','Hf','Zr','Ta','Nb','F','Ga','Sn','Cd','Zn','P2O5','TiO2','MnO','Sc','V','FeO','CaO','Co','MgO','Ni','Cr2O3'};

eval(['data=' name '.' plotitems{1} ';'])

for i=2:length(plotitems)
    eval(sprintf('data=[data %s.%s];', name, plotitems{i}))
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
set(gca,'XTick',[])




