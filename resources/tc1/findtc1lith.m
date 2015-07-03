function in=findtc1lith(in)
% Adds lithospheric thickness to dataset using data from Artemieva's TC1 model
if ~isstruct(in)
    error('Requires struct input')
end

load tc1

lat=round(in.Latitude);
lon=round(in.Longitude);

%Check if out of range
lat(lat>90 | lat<-90)=NaN;
lon(lon>180 | lon<-180)=NaN;

tc1mat550=NaN(181,361);
tc1mat1300=NaN(181,361);
for i=1:length(tc1(:,1))
    tc1mat550(91-tc1(i,1),tc1(i,2)+181)=tc1(i,4);
    tc1mat1300(91-tc1(i,1),tc1(i,2)+181)=tc1(i,3);
end


lithosphere=NaN(length(lat),1);
crust=NaN(length(lat),1);
for i=1:length(lat)
    if ~isnan(lat(i)) && ~isnan(lon(i))
        crust(i)=tc1mat550(91-lat(i),lon(i)+181);
        lithosphere(i)=tc1mat1300(91-lat(i),lon(i)+181);
    end
end


in.tc1Lith=lithosphere;
in.tc1Crust=crust;
    
