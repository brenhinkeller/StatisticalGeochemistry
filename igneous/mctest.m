% mctest.m
% Produce the the (~10^6 row) monte carlo table mcign for quick examination
% with plotmcvariable(s).m
% Uses static per-variable errors, except for age
%%

simitems={'Kv';'Latitude';'Longitude';'Elevation';'SiO2';'TiO2';'Al2O3';'Fe2O3';'Fe2O3T';'FeO';'FeOT';'MgO';'CaO';'Na2O';'K2O';'P2O5';'MnO';'H2O_Total';'La';'Ce';'Pr';'Nd';'Sm';'Eu';'Gd';'Tb';'Dy';'Ho';'Er';'Tm';'Yb';'Lu';'Li';'Be';'B';'C';'CO2';'F';'Cl';'Sc';'Ti';'V';'Cr';'Co';'Ni';'Cu';'Zn';'Ga';'Zr';'Os';'Rb';'Bi';'Hg';'Ba';'Y';'Pb';'Te';'Nb';'Sr87_Sr86';'Tl';'Pt';'Sn';'Cd';'As';'Pd';'Sr';'Se';'S';'Au';'Ta';'Mo';'U';'Cs';'Sb';'Ag';'W';'Th';'Re';'Hf';'Ir';'tc1Lith';'tc1Crust';'Crust';'Vp';'Vs';'Rho';}; % ign

datain=zeros(length(ign.Age),length(simitems)+2);
uncertainty=zeros(1,length(simitems)+2);
for i=1:length(simitems)
    datain(:,i+2)=ign.(simitems{i});
    uncertainty(i+2)=ign.err.(simitems{i});
end
clear i

%% Produce sample weights

datain(:,1)=ign.Age;
agecert=ign.Age_Max-ign.Age_Min;
agecert(agecert<50)=50;
agecert(isnan(agecert))=50;
datain(:,2)=agecert;

% Exclude samples without age and location, located in the oceans below sea level, or oibs
test=~isnan(ign.Age)&~isnan(ign.Latitude)&~isnan(ign.Longitude)&ign.Elevation>-100&~ign.oibs;
data=datain(test,:);

tic;
% Calculate sample weights
k=invweight(ign.Latitude(test),ign.Longitude(test),ign.Age(test));
prob=1./((k.*median(5./k))+1);
fprintf('Calculating sample weights: ')
toc


%% Run the monte carlo

% Number of rows to simulate
samplerows=1E7;

tic;
% Generate matrix to hold resampled data, initialized as NaNs
fprintf('Allocating output matrix: ')
mcign.data=NaN(samplerows,size(data,2));
toc

tic;
% Fill the output data matrix with resampled data
fprintf('Resampling: ')
i=1;
while i<samplerows
    % select weighted sample of data
    r=rand(length(prob),1);
    sdata=data(prob>r,:);
    
    % Randomize ages over uncertainty interval
    r=randn(size(sdata(:,1)));
    sdata(:,1)=sdata(:,1)+r.*sdata(:,2)/2;
    
    if i+size(sdata,1)-1<=samplerows
        mcign.data(i:i+size(sdata,1)-1,:)=sdata;
    else
        mcign.data(i:end,:)=sdata(1:samplerows-i+1,:);
    end
    i=i+size(sdata,1);
end

% Randomize geochemical variables over uncertainty interval
mcign.data=mcign.data+mcign.data.*repmat(uncertainty,samplerows,1).*randn(samplerows,length(simitems)+2);
mcign.elements=['Age';'Age_Uncert';simitems;];


toc
mcign=elementify(mcign);

% save ign ign
save mcign mcign

