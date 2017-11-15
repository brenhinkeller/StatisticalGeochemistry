function rate=findseafloorrate(latitude,longitude,varargin)
% rate=findseafloorrate(latitude, longitude, seafloorrate, seafloorrateerror)
% specifying seafloorrate explicitly in input will speed up calculation,
% but is optional.
if nargin==4 && isstruct(varargin{1})
    seafloorrate=varargin{1};
else
    load seafloorrate
%     load seafloorrateerror
end

% Find the column numbers (using mod to convert lon from -180:180 to 0:360
x=round(mod(longitude, 360)*10800/360+0.5);
% Complete the globe
x(x==10801)=10800;
x(x<1|x>10800)=NaN;

% find the y rows, converting from lat to Mercator (lat -80.738:80.738)
y=4320 - round(8640*asinh(tan(latitude*pi/180))/asinh(tan(80.738*pi/180))/2+0.5);
% NaN off areas north or south of the Mercator limits
y(y==8641)=8640;
y(y<1|y>8640)=NaN;

rate=NaN(length(x),1); %3
for i=1:length(x)
    % If there is rate data for row(i), col(i)
    if ~isnan(x(i)) && ~isnan(y(i))
        % Then fill in the output data (rate, rate_Min, rate_Max)
        rate(i,1)=seafloorrate(y(i),x(i));
%         rate(i,2)=rate(i,1)-seafloorrateerror(y(i),x(i));
%         rate(i,3)=rate(i,1)+seafloorrateerror(y(i),x(i));
    end
end



%% Code for reading from data files
% % Open the rate data file ('r'=read, 'b'=big-endian)
% fid1=fopen('rate.3.2.img','r','b');
% % Read the binary data, which is in integer*2 format, convert to double, 
% % and take the transpose
% seafloorrate=fread(fid1,[10800 8640],'integer*2')';
% % Close the data file
% fclose(fid1);
% % Add NaNs where there is no data
% seafloorrate(seafloorrate(:)==32767)=NaN;
% % Convert to Ma
% seafloorrate=seafloorrate./100;
% % Save
% save seafloorrate seafloorrate
% 
% 
% % The same, but for the rate error data file
% fid1=fopen('rateerror.3.2.img','r','b');
% seafloorrateerror=fread(fid1,[10800 8640],'integer*2')';
% fclose(fid1);
% seafloorrateerror(seafloorrateerror(:)==32767)=NaN;
% seafloorrateerror=seafloorrateerror./100;
% save seafloorrateerror seafloorrateerror

