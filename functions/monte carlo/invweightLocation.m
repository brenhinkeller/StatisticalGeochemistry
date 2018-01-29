function out = invweightLocation(lat,lon,varargin)
% Produce a weighting coefficient for each row of data corresponding 
% to the input lat, lon, and age that is inversely proportional to the 
% spatiotemporal data concentration

% Check if there is lat, lon, and age data
nodata = isnan(lat) | isnan(lon);

% Set exponent for weighting norm
if nargin==2
    p = 2;
else
    p = varargin{1};
end
fprintf('p = %i\n',p)

i=1;
k=zeros(length(lat),1);
fprintf('\n')
while i<=length(lat)
    if nodata(i)
        % If there is no data, set k=inf for weight=0
        k(i)=Inf;
    else
        % Otherwise, calculate weight
        k(i)=nansum(1./((180/pi*acos(sin(lat(i)*pi/180).*sin(lat*pi/180)+cos(lat(i)*pi/180).*cos(lat*pi/180).*cos(lon(i)*pi/180-lon*pi/180))/1.8).^p+1)); 
    end
    % Display progress
    if mod(i,100)==0
        if i>100
            bspstr=repmat('\b',1,floor(log10(i-100))+1);
            fprintf(bspstr)
        end
        fprintf('%i',i)
    end
    % Increment i
    i=i+1;
end
fprintf('\n')
out=k;