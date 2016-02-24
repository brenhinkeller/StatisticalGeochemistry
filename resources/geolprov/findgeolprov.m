function out=findgeolprov(lat,lon)
load geolprov

x=round((lon+180)*2161/360);
y=round((90-lat)*1801/180);
x(x<1 | x>2161)=NaN;
y(y<1 | y>1801)=NaN;

out=zeros(length(lat),1);
for i=1:length(lat)
    if ~isnan(x(i))&&~isnan(y(i))
        out(i)=geolprov(y(i),x(i));
    end
end


%% Read directly from the map image
% function out=findgeolprov(lat,lon)
% % Retrieves age data from the crustal age map in Artemieva's tc1 model.
% 
% % Load the map
% A=imread('geolprov.png');
% 
% 
% 
% %RGB values of colors used in the map
% colors=[141 235 211 % Accreted Arc
%         0   48  255 % Island Arc
%         0   21  115 % Continental Arc
%         2   202 30  % Collisional orogen
% 
%         255 236 117 % Extensional
%         255 63  0   % Rift
%         178 94  191 % Plume
% 
%         235 144 115 % Shield
%         235 163 213 % Platform
%         149 192 237 % Basin 
%         
%         255 255 255 % No data
%         0   0   0   % No data
% ];
% 
% types=[10 % Accreted Arc
%        11 % Island Arc
%        12 % Continental Arc
%        13 % Collisional orogen
%        
%        20 % Extensional
%        21 % Rift
%        22 % Plume
%        
%        31 % Shield
%        32 % Platform
%        33 % Basin
%        
%        NaN % No data
%        NaN % No data
% ];
%
%
% % Find the number of samples there are
% nsamples=length(lat);
% 
% 
% 
% 
% mstruct=defaultm('mercator');
% mstruct.maplatlimit=[-60 75];
% mstruct.maplonlimit=[-180 180];
% mstruct=defaultm(mstruct);
% [x,y]=mfwdtran(mstruct,lat,lon);
% 
% x=round((x+pi)*2045/(2*pi));
% y=round((2.027589421800132-y)*1085/3.344547318724948);
% x(x<1 | x>2045)=NaN;
% y(y<1 | y>1085)=NaN;
% 
% 
% % Read the colors from the map for each pair of coordinates
% r=zeros(nsamples,1);
% g=r;
% b=g;
% for i=1:length(y)
%     if isnan(y(i)) || isnan(x(i))
%         r(i)=0;
%         g(i)=0;
%         b(i)=0;
%     else
%         r(i)=A(y(i),x(i),1);
%         g(i)=A(y(i),x(i),2);
%         b(i)=A(y(i),x(i),3);
%     end
% end
% 
% 
% % Determine which color the map is for each pair of coordinates and output
% % the corresponding types
% out=NaN(nsamples,1);
% for i=1:nsamples
%     [~,bestcolor]=min(sum([colors(:,1)-r(i) colors(:,2)-g(i) colors(:,3)-b(i)].^2,2));
%     out(i)=types(bestcolor,:); % Unnecessary colon?
% end