function age=findseafloorage(latitude,longitude,varargin)
% age=findseafloorage(latitude, longitude, seafloorage, seafloorageerror)
% specifying seafloorage explicitly in input will speed up calculation,
% but is optional.
if nargin==4 && isstruct(varargin{1}) && isstruct(varargin{2})
    seafloorage=varargin{1};
    seafloorageerror=varargin{2};
else
    load seafloorage
    load seafloorageerror
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

age=NaN(length(x),3);
for i=1:length(x)
    % If there is age data for row(i), col(i)
    if ~isnan(x(i)) && ~isnan(y(i))
        % Then fill in the output data (Age, Age_Min, Age_Max)
        age(i,1)=seafloorage(y(i),x(i));
        age(i,2)=age(i,1)-seafloorageerror(y(i),x(i));
        age(i,3)=age(i,1)+seafloorageerror(y(i),x(i));
    end
end


%% Code for reading from data files
% % Open the age data file ('r'=read, 'b'=big-endian)
% fid1=fopen('age.3.2.img','r','b');
% % Read the binary data, which is in integer*2 format, convert to double, 
% % and take the transpose
% seafloorage=fread(fid1,[10800 8640],'integer*2')';
% % Close the data file
% fclose(fid1);
% % Add NaNs where there is no data
% seafloorage(seafloorage(:)==32767)=NaN;
% % Convert to Ma
% seafloorage=seafloorage./100;
% % Save
% save seafloorage seafloorage
% 
% 
% % The same, but for the age error data file
% fid1=fopen('ageerror.3.2.img','r','b');
% seafloorageerror=fread(fid1,[10800 8640],'integer*2')';
% fclose(fid1);
% seafloorageerror(seafloorageerror(:)==32767)=NaN;
% seafloorageerror=seafloorageerror./100;
% save seafloorageerror seafloorageerror


  
  
