function out=findgeolcont(lat,lon)


% Load the map
A=imread('geolcont.png');

colors=[255 242 0   % Africa
        255 36  9   % Australia
        123 0   70  % Europe
        0   13  113 % Asia
        57  181 74  % North America
        3   63  0   % South America
        0   255 252 % Antarctica
        
        255 255 255 % No data
        0   0   0   % No data
];

types=[1 % Africa
       2 % Australia
       3 % Europe
       4 % Asia
       5 % North America
       6 % South America
       7 % Antarctica
       
       0 % No Data
       0 % No Data
];


% Find the number of samples there are
nsamples=length(lat);


x=round((lon+180)*1024/360);
y=round((90-lat)*512/180);
x(x<1 | x>1024)=NaN;
y(y<1 | y>512)=NaN;


% Read the colors from the map for each pair of coordinates
r=zeros(nsamples,1);
g=r;
b=g;
for i=1:length(y)
    if isnan(y(i)) || isnan(x(i))
        r(i)=0;
        g(i)=0;
        b(i)=0;
    else
        r(i)=A(y(i),x(i),1);
        g(i)=A(y(i),x(i),2);
        b(i)=A(y(i),x(i),3);
    end
end


% Determine which color the map is for each pair of coordinates and output
% the corresponding types
out=NaN(nsamples,1);
for i=1:nsamples
    [~,bestcolor]=min(sum([colors(:,1)-r(i) colors(:,2)-g(i) colors(:,3)-b(i)].^2,2));
    out(i)=types(bestcolor,:);
end