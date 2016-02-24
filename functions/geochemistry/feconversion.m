function out=feconversion(in)
% Compiles data from in.FeO, in.FeOt, in.Fe2O3, and in.Fe2O3t into 
% a single in.Fe2O3T vector. 

% Populate temporary variables
Fe2O3=in.Fe2O3;
Fe2O3T=in.Fe2O3T;
FeO=in.FeO;
FeOT=in.FeOT;


% Perform the conversion
i=1;
Fe2O3TT=zeros(length(Fe2O3),1);
conversionfactor=(55.845+1.5*15.999)/(55.845+15.999);
 while i<=length(Fe2O3T)
    if isnan(Fe2O3T(i))
        if isnan(FeOT(i))
            if isnan(FeO(i))
                Fe2O3TT(i)=nansum([Fe2O3(i), FeO(i)*conversionfactor],2);
            end
        else
            Fe2O3TT(i)=FeOT(i)*conversionfactor;
        end
    else
        Fe2O3TT(i)=Fe2O3T(i);
    end
    i=i+1;
 end

 
% Save the results
in.Fe2O3T=Fe2O3TT;
in.FeOT(isnan(FeOT))=Fe2O3TT(isnan(FeOT))./conversionfactor;
out=in;