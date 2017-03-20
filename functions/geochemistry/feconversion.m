function out=feconversion(in)
% Compiles data from in.FeO, in.FeOT, in.Fe2O3, and in.Fe2O3T into 
% a single in.Fe2O3T vector. 

% Perform the conversion
Fe2O3T=NaN(length(in.Fe2O3),1);
conversionfactor=(55.845+1.5*15.999)/(55.845+15.999);
for i=1:length(in.Fe2O3T)
    if isnan(in.Fe2O3T(i))
        if isnan(in.FeOT(i))
            Fe2O3T(i)=nansum([in.Fe2O3(i), in.FeO(i)*conversionfactor],2);
        else
            Fe2O3T(i)=in.FeOT(i)*conversionfactor;
        end
    else
        Fe2O3T(i)=in.Fe2O3T(i);
    end
 end

 
% Save the results
in.Fe2O3T=Fe2O3T;
in.FeOT(isnan(in.FeOT))=Fe2O3T(isnan(in.FeOT))./conversionfactor;
out=in;