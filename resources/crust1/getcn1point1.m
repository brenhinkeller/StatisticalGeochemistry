function getCN1point1(in)

[crustpath,~,~] = fileparts(which('getcrust1data.command'));
cd(crustpath)

test=~isnan(in.Latitude)&~isnan(in.Longitude);
lat=in.Latitude(test);lon=in.Longitude(test);

fid=fopen('coordinates','w');
for i=1:length(lat)
    fprintf(fid,'%.6f, %.6f\n',lat(i),lon(i));
end
fprintf(fid,'q\n');
fclose(fid);

printf('Now navigate to %s in the terminal and run getcrust1data.command before running getCN1point2.m')

% cat coordinates | ./getCN1point > layers.out'

% grep "topography" layers | sed 's/ topography:// > topography.out'
% awk 'c&&!--c;/layers: vp,vs,rho,bottom/{c=6}' layers.out > uppercrust.out
% awk 'c&&!--c;/layers: vp,vs,rho,bottom/{c=7}' layers.out > middlecrust.out
% awk 'c&&!--c;/layers: vp,vs,rho,bottom/{c=8}' layers.out > lowercrust.out

