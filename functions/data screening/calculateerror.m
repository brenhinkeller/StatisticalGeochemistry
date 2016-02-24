function strct=calculateerror(strct)

calculateErrorFor={'Latitude';'Longitude';'Elevation';'SiO2';'TiO2';'Al2O3';'Fe2O3';'Fe2O3T';'FeO';'FeOT';'MgO';'CaO';'Na2O';'K2O';'P2O5';'MnO';'Loi';'H2O_Plus';'H2O_Minus';'H2O';'H2O_Total';'Cr2O3';'La';'NiO';'CaCO3';'Ce';'Pr';'Nd';'Sm';'Eu';'Gd';'Tb';'Dy';'Ho';'Er';'Tm';'Yb';'Lu';'Li';'Be';'B';'C';'CO2';'F';'Cl';'K';'Ca';'Mg';'Sc';'Ti';'V';'Fe';'Cr';'Mn';'Co';'Ni';'Cu';'Zn';'Ga';'Zr';'Os';'Rb';'Pb206_Pb208';'Al';'Bi';'I';'Hg';'Nd143_Nd144';'Ba';'Y';'Pb206_Pb207';'Pb';'D18O';'Te';'Hf176_Hf177';'Nb';'Pb207_Pb204';'Lu176_Hf177';'H';'Pb206_Pb204';'Sr87_Sr86';'Os187_Os188';'Tl';'Pt';'Sn';'Cd';'Pb208_Pb204';'As';'Pd';'Sr';'Se';'S';'Au';'Os187_Os186';'Ta';'P';'Mo';'U';'Cs';'Sb';'Ag';'W';'Th';'Re';'Hf';'Ir';'Crust';'Freeair';'Bouger';'Vp';'Vs';'Rho';'Upper_Crust';'Upper_Vp';'Upper_Vs';'Upper_Rho';'Middle_Crust';'Middle_Vp';'Middle_Vs';'Middle_Rho';'Lower_Crust';'Lower_Vp';'Lower_Vs';'Lower_Rho';'Eustar'};
strct.CalcAbsErr=struct;

for i=1:length(strct.elements)
 
    % Set error based on least significant figure
    if any(ismember(calculateErrorFor, strct.elements{i}))
        strct.err.(strct.elements{i})=0.0001*abs(strct.(strct.elements{i})); % default error 0.1 per mil (100 PPM)
        dfltpwr=floor(log10(nanmedian(abs(strct.(strct.elements{i})))));
        for j=-6:1
            strct.err.(strct.elements{i})(mod(strct.(strct.elements{i}),10^(dfltpwr+j))==0)=10^(dfltpwr+j-1)*3;
        end      
    end
    
    
        
    % Special cases
    
    if any(ismember({'TiO2';'Al2O3';'Fe2O3';'Fe2O3T';'FeO';'FeOT';'MgO';'CaO';'Na2O';'K2O';'P2O5';'MnO';'Loi';'H2O_Plus';'H2O_Minus';'H2O';'H2O_Total';'Cr2O3';'La';'NiO';'CaCO3';'Ce';'Pr';'Nd';'Sm';'Eu';'Gd';'Tb';'Dy';'Ho';'Er';'Tm';'Yb';'Lu';'Li';'Be';'B';'C';'CO2';'F';'Cl';'K';'Ca';'Mg';'Sc';'Ti';'V';'Fe';'Cr';'Mn';'Co';'Ni';'Cu';'Zn';'Ga';'Zr';'Os';'Rb';'Al';'Bi';'I';'Hg';'Ba';'Y';'Pb';'D18O';'Te';'Nb';'Tl';'Pt';'Sn';'Cd';'As';'Pd';'Sr';'Se';'S';'Au';'Ta';'P';'Mo';'U';'Cs';'Sb';'Ag';'W';'Th';'Re';'Hf';'Ir';}, strct.elements{i})) 
        % Set kernel error of 5% for individual elements in MC histograms        
        strct.err.(strct.elements{i})=max(strct.err.(strct.elements{i}), 0.05*abs(strct.(strct.elements{i})));

    elseif any(ismember({'Pb206_Pb208';'Nd143_Nd144';'Pb206_Pb207';'Hf176_Hf177';'Pb207_Pb204';'Lu176_Hf177';'Pb206_Pb204';'Sr87_Sr86';'Os187_Os188';'Pb208_Pb204';'Os187_Os186';}, strct.elements{i}))
        % Set error of 0.1 PPM for isotopes
        strct.err.(strct.elements{i})=0.00000001*strct.(strct.elements{i});
    
    elseif any(ismember({'Crust';'Upper_Crust';'Middle_Crust';'Lower_Crust';'tc1Lith';'tc1Crust';}, strct.elements{i}))
        % Set error of 3% for crust
        strct.err.(strct.elements{i})=abs(strct.(strct.elements{i}))*0.03;
        
    elseif any(ismember({'Vp';'Vs';'Rho';'Upper_Vp';'Upper_Vs';'Upper_Rho';'Middle_Vp';'Middle_Vs';'Middle_Rho';'Lower_Vp';'Lower_Vs';'Lower_Rho';'Freeair';'Bouger';'Elevation';'Eustar'}, strct.elements{i}))
        % Set error of 1% for Vp, Bouger, Elevation
        strct.err.(strct.elements{i})=max(strct.err.(strct.elements{i}), abs(strct.(strct.elements{i}))*0.01);
        
    elseif any(ismember({'Latitude','Longitude'}, strct.elements{i}))
        % Use reported location precision for Latitude and Longitude
        strct.err.(strct.elements{i})(~isnan(strct.Loc_Prec))=strct.Loc_Prec(~isnan(strct.Loc_Prec));
        
    elseif any(ismember({'Age','AgeEst'}, strct.elements{i}))
        % Use reported age precision for age
        strct.err.(strct.elements{i})=(strct.([strct.elements{i} '_Max'])-strct.([strct.elements{i} '_Min']))/2;
        
    elseif any(ismember({'SiO2'}, strct.elements{i}))
        % Use 0.1 per mil for SiO2
        strct.err.(strct.elements{i})=1;%abs(strct.(strct.elements{i}))*0.0001;

    elseif any(ismember({'Kv','Geolprov'}, strct.elements{i}))
        % Zero error for things that aren't variables
        strct.err.(strct.elements{i})=zeros(size(strct.(strct.elements{i})));
    end 
end


