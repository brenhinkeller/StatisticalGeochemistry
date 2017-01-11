%% Plot MgO vs FeOT
if ~exist('mcign','var')
    load mcign
end
if ~exist('ign','var')
    load ign
end


nTimeBins = 4; % Number of time slices you'd like
timeRange = linspace(0,4000,nTimeBins+1);

figure; 
hold on
for i = 1:length(timeRange)-1;
    test=mcign.FeOT>0&mcign.Age>timeRange(i)&mcign.Age<timeRange(i+1);
    [c,m,e]=bin(mcign.MgO(test),mcign.FeOT(test),0,12,length(mcign.SiO2)./length(ign.SiO2),10);
    errorbar(c,m,2*e,'.-','color',[i/5 0 1-i/5])    
end

xlabel('MgO'); ylabel('FeOT')
formatfigure

%% Plot SiO2 vs FeO*/MgO
nTimeBins = 4; % Number of time slices you'd like
timeRange = linspace(0,4000,nTimeBins+1);

figure
hold on
for i = 1:length(timeRange)-1;
    test=mcign.FeOT>0&mcign.MgO>0&mcign.Age>timeRange(i)&mcign.Age<timeRange(i+1);
    [c,m,e]=bin(mcign.SiO2(test),mcign.FeOT(test)./(mcign.FeOT(test)+mcign.MgO(test)),45,75,length(mcign.SiO2)./length(ign.SiO2),10); [m e]=fracttoratio(m,e);
    errorbar(c,m,2*e,'.-','color',[i/5 0 1-i/5])
end

xlabel('SiO2 (wt%)'); ylabel('FeOT / MgO ')
formatfigure

%% Plot SiO2 vs MgO

nTimeBins = 4; %number of time slices you'd like
timeRange = linspace(0,4000,nTimeBins+1);

Elem='MgO';

figure
hold on
for i = 1:length(timeRange)-1;
    test=mcign.(Elem)>0&mcign.Age>timeRange(i)&mcign.Age<timeRange(i+1);
    [c,m,e]=bin(mcign.SiO2(test),mcign.(Elem)(test),40,80,length(mcign.SiO2)./length(ign.SiO2),10);
    errorbar(c,m,2*e,'.-','color',[i/(length(timeRange)-1) 0 1-i/(length(timeRange)-1)])
    %polytool(c,m,4,0.05)
end

xlabel('SiO2'); ylabel(Elem)
formatfigure

%% Plot MgO vs Na2O

nTimeBins = 4; %number of time slices you'd like
timeRange = linspace(0,4000,nTimeBins+1);

Elem='Na2O';

figure
hold on
for i = 1:length(timeRange)-1;
    test=mcign.(Elem)>0&mcign.Age>timeRange(i)&mcign.Age<timeRange(i+1);
    [c,m,e]=bin(mcign.MgO(test),mcign.(Elem)(test),4,10,length(mcign.SiO2)./length(ign.SiO2),6);
    errorbar(c,m,2*e,'.-','color',[i/(length(timeRange)-1) 0 1-i/(length(timeRange)-1)])
    %polytool(c,m,4,0.05)
end

xlabel('MgO'); ylabel(Elem)
formatfigure

%% Plot MgO vs CaO / Al2O3

nTimeBins = 4; % Number of time slices you'd like
timeRange = linspace(0,4000,nTimeBins+1);

Num='CaO';
Den='Al2O3';

figure
hold on
for i = 1:length(timeRange)-1;
    test=mcign.(Num)>0&mcign.(Den)>0&mcign.Age>timeRange(i)&mcign.Age<timeRange(i+1);
    [c,m,e]=bin(mcign.MgO(test),mcign.(Num)(test)./(mcign.(Num)(test)+mcign.(Den)(test)),4,10,length(mcign.SiO2)./length(ign.SiO2),6); [m e]=fracttoratio(m,e);
    errorbar(c,m,2*e,'.-','color',[i/(length(timeRange)-1) 0 1-i/(length(timeRange)-1)])
end

xlabel('MgO'); ylabel([Num '  /  ' Den])
formatfigure


%% Plot MgO vs TiO2

nTimeBins = 4; % Number of time slices you'd like
timeBinWidth = 4000/nTimeBins;
timeRange = linspace(0,4000,nTimeBins+1);

figure; 
hold on
for i = 1:length(timeRange)-1;
    test=mcign.TiO2>0&mcign.Age>timeRange(i)&mcign.Age<timeRange(i+1);
    [c m e]=bin(mcign.MgO(test),mcign.TiO2(test),0,12,length(mcign.SiO2)./length(ign.SiO2),10);
    errorbar(c,m,2*e,'.-','color',[i/(length(timeRange)-1) 0 1-i/(length(timeRange)-1)])    
end

xlabel('MgO'); ylabel('TiO2')

%% Plot MgO vs Na2O

nTimeBins = 4; %number of time slices you'd like
timeRange = linspace(0,4000,nTimeBins+1);

Elem='Na2O';

figure
hold on
for i = 1:length(timeRange)-1;
    test=mcign.(Elem)>0&mcign.Age>timeRange(i)&mcign.Age<timeRange(i+1);
    [c,m,e]=bin(mcign.MgO(test),mcign.(Elem)(test),3,12,length(mcign.SiO2)./length(ign.SiO2),8);
    errorbar(c,m,2*e,'.-','color',[i/(length(timeRange)-1) 0 1-i/(length(timeRange)-1)])
    %polytool(c,m,4,0.05)
end

xlabel('MgO'); ylabel(Elem)
formatfigure

