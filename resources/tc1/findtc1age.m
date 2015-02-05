function out=findtc1age(lat,lon)
% Retrieves age data from the crustal age map in Artemieva's tc1 model.

% Load the map
A=imread('tc1age.png');

% RGB values of the colors used in the map
colors=[171  45  22
        230 129  55
        255 248  54
        171 245  49
         94 183  47
        114 250 253
         96 138 249
         15  45 138
        120  43 183
        255 255 255
          0   0   0];

% Corresponding age, minimum, and maximum values
ages=[  25    0   50
       150   50  250
       395  250  540
       695  540  850
       975  850 1100
      1400 1100 1700
      2100 1700 2500
      2750 2500 3000
      3250 3000 3500
       NaN  NaN  NaN
       NaN  NaN  NaN];

   
% Ensure latitude and longitude are within bounds
if max(lat)>90 || min(lat)<-90
    fprintf('Warning: latitude may be out of bounds\n')
end
if max(lon)>180 || min(lon)<-180
    fprintf('Warning: longitude may be out of bounds\n')
end
lat=mod(lat+90,180)-90;
lon=mod(lat+180,360)-180;
   

% Find the number of samples there are
nsamples=length(lat);

% Convert latitude and longitude into coordinates in the map
j=round((90-lat)*3+0.5);
k=round((lon+180)*3+0.5);
j(j==541)=540;
k(k==1081)=1080;

% Read the colors from the map for each pair of coordinates
r=zeros(nsamples,1);
g=r;
b=g;
for i=1:length(j)
    if isnan(j(i)) || isnan(k(i))
        r(i)=0;
        g(i)=0;
        b(i)=0;
    else
        r(i)=A(j(i),k(i),1);
        g(i)=A(j(i),k(i),2);
        b(i)=A(j(i),k(i),3);
    end
end


% Determine which color the map is for each pair of coordinates and output
% the corresponding ages
out=NaN(nsamples,3);
for i=1:nsamples
    [~,bestcolor]=min(sum([colors(:,1)-r(i) colors(:,2)-g(i) colors(:,3)-b(i)].^2,2));
    out(i,:)=ages(bestcolor,:);
end


