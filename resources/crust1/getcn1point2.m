function [in]=getCN1point2(in)

[crustpath,~,~] = fileparts(which('getcrust1data.command'));
cd(crustpath)

% Input files
load topography.out
load uppercrust.out
load middlecrust.out
load lowercrust.out

% Types of information we have on the crust
types={'Vp','Vs','Rho','Crust'};


% We only want to look at points where we have lat and lon data
test=~isnan(in.Latitude)&~isnan(in.Longitude);
varsize=size(in.Longitude);

% Place data into struct
for i=1:length(types)
    in.(['Upper_' types{i}])=NaN(varsize);
    in.(['Middle_' types{i}])=NaN(varsize);
    in.(['Lower_' types{i}])=NaN(varsize);
    
    in.(['Upper_' types{i}])(test)=uppercrust(:,i);
    in.(['Middle_' types{i}])(test)=middlecrust(:,i);
    in.(['Lower_' types{i}])(test)=lowercrust(:,i);
end

% Convert crust from depth to thickness
top=NaN(varsize);
top(test)=topography;

in.Lower_Crust=in.Middle_Crust-in.Lower_Crust;
in.Middle_Crust=in.Upper_Crust-in.Middle_Crust;
in.Upper_Crust=top-in.Upper_Crust;

% Calculate average for total crust
in.Crust=in.Upper_Crust+in.Middle_Crust+in.Lower_Crust;
in.Vp=(in.Upper_Vp.*in.Upper_Crust + in.Middle_Vp.*in.Middle_Crust + in.Lower_Vp.*in.Lower_Crust) ./ in.Crust;
in.Vs=(in.Upper_Vs.*in.Upper_Crust + in.Middle_Vs.*in.Middle_Crust + in.Lower_Vs.*in.Lower_Crust) ./ in.Crust;
in.Rho=(in.Upper_Rho.*in.Upper_Crust + in.Middle_Rho.*in.Middle_Crust + in.Lower_Rho.*in.Lower_Crust) ./ in.Crust;

[~,~]=unix('rm ./*.out');
[~,~]=unix('rm ./coordinates');


