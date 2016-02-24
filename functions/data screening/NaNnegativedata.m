function strct=deletenegativedata(strct)

positiveOnlyFor={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Fe2O3T';'FeO';'FeOT';'MgO';'CaO';'Na2O';'K2O';'P2O5';'MnO';'Loi';'H2O_Plus';'H2O_Minus';'H2O';'H2O_Total';'Cr2O3';'La';'NiO';'CaCO3';'Ce';'Pr';'Nd';'Sm';'Eu';'Gd';'Tb';'Dy';'Ho';'Er';'Tm';'Yb';'Lu';'Li';'Be';'B';'C';'CO2';'F';'Cl';'K';'Ca';'Mg';'Sc';'Ti';'V';'Fe';'Cr';'Mn';'Co';'Ni';'Cu';'Zn';'Ga';'Zr';'Os';'Rb';'Pb206_Pb208';'Al';'Bi';'I';'Hg';'Nd143_Nd144';'Ba';'Y';'Pb206_Pb207';'Pb';'Te';'Hf176_Hf177';'Nb';'Pb207_Pb204';'Lu176_Hf177';'H';'Pb206_Pb204';'Sr87_Sr86';'Os187_Os188';'Tl';'Pt';'Sn';'Cd';'Pb208_Pb204';'As';'Pd';'Sr';'Se';'S';'Au';'Os187_Os186';'Ta';'P';'Mo';'U';'Cs';'Sb';'Ag';'W';'Th';'Re';'Hf';'Ir';'Eustar';'Crust';'Vp';'Vs';'Rho';'Upper_Crust';'Upper_Vp';'Upper_Vs';'Upper_Rho';'Middle_Crust';'Middle_Vp';'Middle_Vs';'Middle_Rho';'Lower_Crust';'Lower_Vp';'Lower_Vs';'Lower_Rho'};

for i=1:length(strct.elements)
    % NaN out zero and negative data
    if any(ismember(positiveOnlyFor, strct.elements{i}))
        strct.(strct.elements{i})(strct.(strct.elements{i})<=0)=NaN;
    end
end