function map(lat,lon,varargin)    
if nargin>2
    hldon=strcmp(varargin,'hold on');
    style=varargin(~hldon);
else
    style={'.y'};
end

if nargin>3 && sum(hldon);
    hold on; plot((lon+180)*128/45,(90-lat)*128/45,style{:})
    return
end

A=imread('world1024.jpg'); % World satellite image
% A=imread('tc1lithosphere.png'); % Lithospheric thickness model
imshow(A)

hold on
plot((lon+180)*128/45,(90-lat)*128/45,style{:})
