function elev=findelevation(lat,lon,varargin)

if nargin==3 && isstruct(varargin{1})
    etopoelev=varargin{1};
else
    load etopoelev
end

% eliminate erroneous lat and lon
lat(lat<-90|lat>90)=NaN;
lon(lon<-180|lon>180)=NaN;

% Scale factor used in map (=nrows/180=ncols/360)
sf=60;

% Convert latitude and longitude into coordinates in the map.
row=round((90+lat)*sf+0.5);
col=round((180+lon)*sf+0.5);
row(row==(180*sf+1))=180*sf;
col(col==(360*sf+1))=360*sf;


% Create output vector
elev=NaN(length(lat),1);
for i=1:length(lat)
    if isnan(row(i))||isnan(col(i))
        elev(i)=NaN; % Result is NaN if either input is NaN
    else
        elev(i)=etopoelev(row(i),col(i)); % Otherwise, find result
    end
end