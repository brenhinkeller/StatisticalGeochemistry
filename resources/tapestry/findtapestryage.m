function [age, type] = findtapestryage(lat,lon,varargin)
% function color = findtapestryage(lat,lon,varargin)

if nargin==3 && isstruct(varargin{1})
    tapestry=varargin{1};
else
    load tapestry
end

% Reproject the lat,lon into map coordinates
[x,y] = mfwdtran(tapestry.mstruct,lat,lon);

% Calculate the map matrix row and column corresponding to lat and lon
row=round(6537.5-y*9400);
col=round(6870.5+x*9400);
row(row<1 | row>13075)=NaN;
col(col<1 | col>13741)=NaN;


age=NaN(length(row),3);
type=NaN(length(row),1);
% color=NaN(length(row),1);
for i=1:length(row)
    
    % If there is age data for row(i), col(i)
    if  ~isnan(row(i)) && ~isnan(col(i))
        % Then fill in the output data
        age(i,:)=tapestry.ages(tapestry.color(row(i),col(i)),:);
        type(i)=tapestry.type(ceil(row(i)*2248/13075),ceil(col(i)*2363/13741));
%         color(i,:)=tapestry.color(row(i),col(i));

    end
end


%% Code for creating tapestry struct
% % Create struct and define keyelements
% tapestry.keyelements=importdata('tapestryelements.csv');
% 
% % Create data matrix
% tapestry.keydata=zeros(401*length(tapestry.keyelements),4);
% for i=1:length(tapestry.keyelements)
%     
%     % Read each key image and keep the c,m,y (but not k) values
%     tapestry.key.(tapestry.keyelements{i})=imread([tapestry.keyelements{i} '.tif']);
%     tapestry.key.(tapestry.keyelements{i})=tapestry.key.(tapestry.keyelements{i})(:,:,1:3);
%     
%     % Populate the data matrix
%     tapestry.keydata(1+401*(i-1):401*i,1:3)=tapestry.key.(tapestry.keyelements{i});
%     tapestry.keydata(1+401*(i-1):401*i,4)=i*ones(401,1);
% end
% 
% % Load age list
% tapestry.ages=importdata('tapestryages.csv','\t');
% 
% 
% % Load the tapestry image
% gunzip('tapestry.tif.gz')
% A=imread('tapestry.tif');
% gzip('tapestry.tif')
% c=double(A(:,:,1));
% m=double(A(:,:,2));
% y=double(A(:,:,3));
% clear A
% 
% tic;
% % Calculate the best-fig color for each pixel
% tapestry.color=zeros(size(c),'uint8');
% for i=1:(size(c,1)*size(c,2))
%     if c(i)==153 && m(i)==102 && y(i)==102
%         tapestry.color(i)=15;
%     else
%         [~,bestcolor]=min(sum([tapestry.keydata(:,1)-c(i) tapestry.keydata(:,2)-m(i) tapestry.keydata(:,3)-y(i)].^2,2));
%         tapestry.color(i)=tapestry.keydata(bestcolor,4);
%     end
%     
% end
% 
% % Define map structure
% tapestry.mstruct = defaultm('eqaazim');
% tapestry.mstruct.origin = [45 -100];
% tapestry.mstruct = defaultm(tapestry.mstruct);
% 
% 
% typenames={'volcanic'    'volc'
%            'plutonic'    'plut'
%            'metamorphic' 'meta'
%            'sedimentary' 'seds'};
%        
% for j=1:size(typenames,1)
%     
%     v=imread([typenames{j,1} '.tif']);
%     n=imread('notthat.tif');
%     
%     tapestry.(typenames{j,1}).keydata=zeros(802,4);
%     tapestry.(typenames{j,1}).keydata(1:401,1:3)=v(:,:,1:3);
%     tapestry.(typenames{j,1}).keydata(402:802,1:3)=n(:,:,1:3);
%     tapestry.(typenames{j,1}).keydata(1:401,4)=j;
%     tapestry.(typenames{j,1}).keydata(402:802,4)=NaN;
%     
%     
%     gunzip([typenames{j,2} '.tif.gz'])
%     A=imread([typenames{j,2} '.tif']);
%     gzip([typenames{j,2} '.tif'])
%     c=double(A(:,:,1));
%     m=double(A(:,:,2));
%     y=double(A(:,:,3));
%     clear A
%     
%     tapestry.(typenames{j,1}).type=zeros(size(c));
%     for i=1:(size(c,1)*size(c,2))
%         if c(i)==153 && m(i)==102 && y(i)==102
%             tapestry.(typenames{j,1}).type(i)=NaN;
%         else
%             [~,besttype]=min(sum([tapestry.(typenames{j,1}).keydata(:,1)-c(i) tapestry.(typenames{j,1}).keydata(:,2)-m(i) tapestry.(typenames{j,1}).keydata(:,3)-y(i)].^2,2));
%             tapestry.(typenames{j,1}).type(i)=tapestry.(typenames{j,1}).keydata(besttype,4);
%         end
%         
%     end
%     
% end
% toc
% 
% tapestry.type=tapestry.sedimentary.type;
% tapestry.type(~isnan(tapestry.metamorphic.type(:)))=tapestry.metamorphic.type(~isnan(tapestry.metamorphic.type(:)));
% tapestry.type(~isnan(tapestry.plutonic.type(:)))=tapestry.plutonic.type(~isnan(tapestry.plutonic.type(:)));
% tapestry.type(~isnan(tapestry.volcanic.type(:)))=tapestry.volcanic.type(~isnan(tapestry.volcanic.type(:)));
% 
% % Save results
% save tapestry tapestry





