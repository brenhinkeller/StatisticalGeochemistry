%% exportBinnedMCAverages.m
% Exports binned averages for a set of chosen geochemical variables from  
% the igneous whole-rock database.
% Binning scheme may be both by silica range and by age.

%% Load files
if ~exist('mcign','var'); load mcign; end
if ~exist('ign','var'); load ign; end
mcign=findOIBs(mcign);


%% Elements to export
elements={'CaO';'K2O';'SiO2';'MgO';'Rb';'Sr'};

% Options include:'SiO2';'TiO2';'Al2O3';'Fe2O3';'Fe2O3T';'FeO';'FeOT';'MgO';'CaO';'Na2O';'K2O';'P2O5';'MnO';'H2O_Total';'La';'Ce';'Pr';'Nd';'Sm';'Eu';'Gd';'Tb';'Dy';'Ho';'Er';'Tm';'Yb';'Lu';'Li';'Be';'B';'C';'CO2';'F';'Cl';'Sc';'Ti';'V';'Cr';'Co';'Ni';'Cu';'Zn';'Ga';'Zr';'Os';'Rb';'Bi';'Hg';'Ba';'Y';'Pb';'Te';'Nb';'Sr87_Sr86';'Tl';'Pt';'Sn';'Cd';'As';'Pd';'Sr';'Se';'S';'Au';'Ta';'Mo';'U';'Cs';'Sb';'Ag';'W';'Th';'Re';'Hf';'Ir';

%% Timeseries properties
agemin=0;
agemax=4000;
timestep=100;
nbins=(agemax-agemin)/timestep;

%% Binned average for silica ranges

SiRange=[43,51,62,74,80];

for i=1:(length(SiRange)-1)
    output = zeros(nbins,2*length(elements)+1);
    for j = 1:length(elements)
        elem=elements{j};
        test=~isnan(mcign.(elem)) & mcign.SiO2>SiRange(i) & mcign.SiO2<SiRange(i+1) & mcign.Elevation>-100 & ~mcign.oibs;
        [c,m,e]=bin(mcign.Age(test),mcign.(elem)(test),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
        figure; errorbar(c,m,2*e,'.b');
        xlabel('Age (Ma)'); ylabel(elem);

        output(:,2*j)=m';
        output(:,2*j+1)=2*e';
    end
    output(:,1)=c;
    
    filestring = sprintf('%i-%iMa%i-%i%%SiO2.csv',agemin,agemax,SiRange(i),SiRange(i+1));
    fid = fopen(filestring,'w');
    
    fprintf(fid,'Age bin (Ma)\t');
    for j=1:length(elements)
        fprintf(fid,'%s\t2se\t',elements{j});
    end
    
    for j=1:size(output,1)
        fprintf(fid,'\n');
        for k=1:size(output,2)
            fprintf(fid,'%g\t',output(j,k));
        end
    end
    
    fclose(fid);
end


%%
if ~exist('igntext','var'); load igntext; end
% SiRange=[43,51,62,74,80];
SiRange=[40,80];

% Figures
for i=1:(length(SiRange)-1)
    titlestring = sprintf('%i-%iMa%i-%i%%SiO2',agemin,agemax,SiRange(i),SiRange(i+1));
    for j = 1:length(elements);
        elem=elements{j};
        test=~isnan(mcign.(elem)) & mcign.SiO2>SiRange(i) & mcign.SiO2<SiRange(i+1) & mcign.Elevation>-100 & ~mcign.oibs;
        
        testp=test&strcmpi(igntext.Type(interp1(ign.Kv,(1:length(ign.Kv))',mcign.Kv)),'plutonic'); % Only look at plutonic samples;   
        [c,m,e]=bin(mcign.Age(testp),mcign.(elem)(testp),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
        figure; errorbar(c,m,2*e,'.b');

        testv=test&strcmpi(igntext.Type(interp1(ign.Kv,(1:length(ign.Kv))',mcign.Kv)),'volcanic'); % Only look at volcanic samples;
        [c,m,e]=bin(mcign.Age(testv),mcign.(elem)(testv),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
        hold on; errorbar(c,m,2*e,'.r');
        
        xlabel('Age (Ma)'); ylabel(elem); title(titlestring);
        print([titlestring 'VP.jpg'], '-r300','-djpeg')
    end
end

% Volcanic
for i=1:(length(SiRange)-1)
    output = zeros(nbins,2*length(elements)+1);
    titlestring = sprintf('%i-%iMa%i-%i%%SiO2',agemin,agemax,SiRange(i),SiRange(i+1));
    for j = 1:length(elements);
        elem=elements{j};
        test=~isnan(mcign.(elem)) & mcign.SiO2>SiRange(i) & mcign.SiO2<SiRange(i+1) & mcign.Elevation>-100 & ~mcign.oibs;
        
        testv=test&strcmpi(igntext.Type(interp1(ign.Kv,(1:length(ign.Kv))',mcign.Kv)),'volcanic'); % Only look at volcanic samples;
        [c,m,e]=bin(mcign.Age(testv),mcign.(elem)(testv),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
        
        output(:,2*j)=m';
        output(:,2*j+1)=2*e';
    end
    output(:,1)=c;
    
    fid = fopen([titlestring 'volcanic.csv'],'w');
    
    fprintf(fid,'Age bin (Ma)\t');
    for j=1:length(elements)
        fprintf(fid,'%s\t2se\t',elements{j});
    end
    
    for j=1:size(output,1)
        fprintf(fid,'\n');
        for k=1:size(output,2)
            fprintf(fid,'%g\t',output(j,k));
        end
    end
    
    fclose(fid);
end



% Plutonic
for i=1:(length(SiRange)-1)
    output = zeros(nbins,2*length(elements)+1);
    titlestring = sprintf('%i-%iMa%i-%i%%SiO2',agemin,agemax,SiRange(i),SiRange(i+1));
    for j = 1:length(elements);
        elem=elements{j};
        test=~isnan(mcign.(elem)) & mcign.SiO2>SiRange(i) & mcign.SiO2<SiRange(i+1) & mcign.Elevation>-100 & ~mcign.oibs;
        
        testp=test&strcmpi(igntext.Type(interp1(ign.Kv,(1:length(ign.Kv))',mcign.Kv)),'plutonic'); % Only look at plutonic samples;
        [c,m,e]=bin(mcign.Age(testp),mcign.(elem)(testp),agemin,agemax,length(mcign.SiO2)./length(ign.SiO2),nbins);
        
        output(:,2*j)=m';
        output(:,2*j+1)=2*e';
    end
    output(:,1)=c;
    
    fid = fopen([titlestring 'plutonic.csv'],'w');
    
    fprintf(fid,'Age bin (Ma)\t');
    for j=1:length(elements)
        fprintf(fid,'%s\t2se\t',elements{j});
    end
    
    for j=1:size(output,1)
        fprintf(fid,'\n');
        for k=1:size(output,2)
            fprintf(fid,'%g\t',output(j,k));
        end
    end
    
    fclose(fid);
end
