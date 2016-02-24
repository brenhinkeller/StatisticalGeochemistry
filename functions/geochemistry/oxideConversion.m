function struct=oxideConversion(struct)
source={'Si','Ti','Al','Fe','Fe','Mg','Ca','Mn','Na','K','P','Cr','Ni','Co','C','S','H'};
dest={'SiO2','TiO2','Al2O3','FeOT','Fe2O3T','MgO','CaO','MnO','Na2O','K2O','P2O5','Cr2O3','NiO','CoO','CO2','SO2','H2O'};
% for i=1:length(source)
%     conversionfactor(i)=mass.percation.(dest{i})./mass.(source{i});
% end
conversionfactor=[2.13932704290547,1.66847584248889,1.88944149488507,1.28648836426407,1.42973254639611,1.65825961736268,1.39919258253823,1.29121895771597,1.34795912485574,1.20459963614796,2.29133490474735,1.46154369861159,1.27258582901258,1.27147688434143,3.66405794688203,1.99806612601372,8.93601190476191];

% If both fields exist, fill in destination from source
for i=1:length(source)
    if isfield(struct,source{i}) && isfield(struct,dest{i})
        test=isnan(struct.(dest{i})) & ~isnan(struct.(source{i}));
        struct.(dest{i})(test)=struct.(source{i})(test).*conversionfactor(i)/10000; %Convert from PPM to percent
    end
end
