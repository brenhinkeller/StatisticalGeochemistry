function [out]=findgravity(lat,lon,varargin)
% findgravity(Latitude, Longitude, data type, topex) data type =
% 'freeair','bouger','topo'

method='freeair'; % Default method


if nargin>2 && isstruct(varargin{1})
    topex=varargin{1};
    if nargin>3 && ischar(varargin{2})
        method=varargin{2};
    end
elseif nargin>3 && isstruct(varargin{2});
    topex=varargin{2};
    if ischar(varargin{1})
        method=varargin{1};
    end
else
    load topex
end


[x y]=mfwdtran(topex.mstruct,lat,lon);
row=round(8640-y*3437.746771+0.500001);
col=round(10800+x*3437.74677+0.500001);
row(row<1 | row>17280)=NaN;
col(col<1 | col>21600)=NaN;

data=topex.(method);
out=NaN(size(x));
for i=1:length(x(:))
    if ~isnan(row(i)) && ~isnan(col(i))
        out(i)=data(row(i),col(i));
    end
end

% %% Prepare topex.mat file
% fid=fopen('grav.img.20.1');
% A=fread(fid,[21600,17280],'integer*2','b');
% fclose(fid);
% A=A';
% mstruct=defaultm('mercator');
% mstruct.origin=[0 180];
% mstruct.maplatlimit=[-80.738,80.738];
% mstruct=defaultm(mstruct);
% topex.mstruct=mstruct;
% topex.freeair=A;
% 
% fid=fopen('topo_15.1.img');
% B=fread(fid,[21600,17280],'integer*2','b');
% fclose(fid);
% B=B';
% topex.topo=B;
% 
% gravmintopo=(grav+9800000)-1.536330076057203*(topo+6378100);
% for i=1:size(gravmintopo,1)
%     gravmintopo2(i,:)=smooth(gravmintopo(i,:),3);
% end
% for i=1:size(gravmintopo,2)
%     gravmintopo2(:,i)=smooth(gravmintopo2(:,i),3);
% end
% topex.bouger=gravmintopo2;
% 
% % figure; imagesc(gravmintopo2,[-4500 11000])
% % gravmintopo2(topo<0)=NaN;
% % figure; imagesc(gravmintopo2,[-4500 3000])
% 
% 
% save -v7.3 topex topex
%
%
% %% Try interpolating gravity
% [x y]=meshgrid(1:21600,1:17280);
% F=griddedInterpolant(x',y',topex.freeair');
%
% [lon lat]=meshgrid(-130:0.01:-90,35:0.01:50);
% res=0.02;
% [lon lat]=meshgrid(-118:res:-113,37:res:40);
% [lon lat]=meshgrid(-115:res:-114,38:res:39);
%
% [x y]=mfwdtran(topex.mstruct,lat,lon);
% row=round(8640-y*3437.746771+0.500001);
% col=round(10800+x*3437.74677+0.500001);
% row(row<1 | row>17280)=NaN;
% col(col<1 | col>21600)=NaN;
% 
% out=F(col,row);
% out=NaN(size(x));
% for i=1:length(x(:))
%     if ~isnan(row(i)) && ~isnan(col(i))
%         out(i)=F(col(i),row(i));
%     end
% end
% n=0.02/res;
% if n>1
%     out=smooth2(out,n,n);
% end
% figure; imagesc(out,[-1000 1500])
% set(gca,'Ydir','normal')