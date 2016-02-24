function mapscatter(lat,lon,s,c)    

A=imread('world1024.jpg'); % World satellite image
% A=imread('tc1lithosphere.png'); % Lithospheric thickness model
imshow(A)

hold on
scatter((lon+180)*128/45,(90-lat)*128/45,s,c)
