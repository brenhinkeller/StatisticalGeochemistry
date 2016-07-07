function out = invweight(lat,lon,age)
% Produce a weighting coefficient for each row of data corresponding 
% to the input lat, lon, and age that is inversely proportional to the 
% spatiotemporal data concentration

% Check if there is lat, lon, and age data
nodata=isnan(lat) | isnan(lon) | isnan(age);

i=1;
k=zeros(length(lat),1);
fprintf('\n')
while i<=length(lat)
    if nodata(i)
        % If there is no data, set k=inf for weight=0
        k(i)=Inf;
    else
        % Otherwise, calculate weight
        k(i)=nansum(1./((180/pi*acos(sin(lat(i)*pi/180).*sin(lat*pi/180)+cos(lat(i)*pi/180).*cos(lat*pi/180).*cos(lon(i)*pi/180-lon*pi/180))/1.8).^2+1)...
            +1./((((age(i))-age)/38).^2+1));        
%         ka(i)=nansum(1./((acos(sin(lat(i)*pi/180).*sin(lat*pi/180)+cos(lat(i)*pi/180).*cos(lat*pi/180).*cos(lon(i)*pi/180-lon*pi/180))*180/pi/.018).^2+1));
%         kb(i)=nansum(1./(((age(i)-age)/.38).^2+1));
%         k(i)=nansum(1./(((((lat(i))-lat)/2).^2+(((lon(i))-lon)/2).^2+1))...
%             +1./((((age(i))-age)./75).^2+1));

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