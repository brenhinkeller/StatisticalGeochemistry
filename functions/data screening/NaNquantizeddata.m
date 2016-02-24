function strct=deletequantizeddata(strct)

nbins=1000;
deleteQuantizedFor={'SiO2';'TiO2';'Al2O3';'Fe2O3';'Fe2O3T';'FeO';'FeOT';'MgO';'CaO';'Na2O';'K2O';'P2O5';'MnO';'Loi';'H2O_Plus';'H2O_Minus';'H2O';'H2O_Total';'Cr2O3';'La';'NiO';'CaCO3';'Ce';'Pr';'Nd';'Sm';'Eu';'Gd';'Tb';'Dy';'Ho';'Er';'Tm';'Yb';'Lu';'Li';'Be';'B';'C';'CO2';'F';'Cl';'K';'Ca';'Mg';'Sc';'Ti';'V';'Fe';'Cr';'Mn';'Co';'Ni';'Cu';'Zn';'Ga';'Zr';'Os';'Rb';'Al';'Bi';'I';'Hg';'Ba';'Y';'Pb';'Te';'Nb';'H';'Tl';'Pt';'Sn';'Cd';'As';'Pd';'Sr';'Se';'S';'Au';'Ta';'P';'Mo';'U';'Cs';'Sb';'Ag';'W';'Th';'Re';'Hf';'Ir';'Eustar'};

for i=1:length(strct.elements)
    if any(ismember(deleteQuantizedFor, strct.elements{i}))
        % Calculate number of signifcant figures
        strct.sigfigs.(strct.elements{i})=sigfigs(strct.(strct.elements{i}));
        
        % Calculate relative degeneracy
        binEdges=linspace(min(strct.(strct.elements{i})),max(strct.(strct.elements{i})),nbins+1);
        strct.degeneracy.(strct.elements{i})=NaN(size(strct.(strct.elements{i})));
        n=histc(strct.(strct.elements{i}), binEdges);
        d=zeros(nbins,1);
        for j=1:nbins
            l=max([round(j-length(n)/10),1]);
            u=min([round(j+length(n)/10),length(n)]);
            d(j)=n(j)./nansum(n(l:u));
            strct.degeneracy.(strct.elements{i})(strct.(strct.elements{i})>binEdges(j)&strct.(strct.elements{i})<binEdges(j+1))=d(j);
        end
        
        % Calculate quality factor
        v = 4.^(strct.sigfigs.(strct.elements{i})-1) ./ strct.degeneracy.(strct.elements{i}) .* nanstd(strct.(strct.elements{i})) ./  abs(strct.(strct.elements{i})) .* (1+10^-4*randn(size(strct.(strct.elements{i}))));
        
        % Delete data with quality factor lower than 100, or below the 5th percentile (whichever is lower)
        test=v<min([100 prctile(v,5.00)]);
        strct.(strct.elements{i})(test)=NaN;
        
        fprintf('Element %s: deleted %i of %i data points (%.3g percent)\n', strct.elements{i}, sum(test), sum(~isnan(strct.(strct.elements{i}))), sum(test)/sum(~isnan(strct.(strct.elements{i})))*100)
    end
end
