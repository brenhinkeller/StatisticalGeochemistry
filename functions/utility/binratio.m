function [bincenters,averages,errors]=binratio(x,num,den,min,max,oversamplingratio,nbins,varargin)
if nargin==7
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;
    
    averages=NaN(1,nbins);
    errors=NaN(1,nbins);

    for i=1:nbins
        t = (x>binedges(i)&x<binedges(i+1));
        averages(i)=nanmean(num(t))./nanmean(den(t));
        errors(i)=sqrt((nansem(num(t))./nanmean(num(t))).^2 + (nansem(den(t))./nanmean(den(t))).^2 ) .* sqrt(oversamplingratio);
    end
    
    
elseif nargin==8
    binoverlap=varargin{1};
    
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);
    
    averages=NaN(1,nbins);
    errors=NaN(1,nbins);
    
    for i=1:nbins
        t=(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth);
        averages(i)=nanmean(num(t))./nanmean(den(t));
        errors(i)=sqrt( (nansem(num(t))./nanmean(num(t))).^2 + (nansem(den(t))./nanmean(den(t))).^2 ) .* sqrt(oversamplingratio);
    end  
elseif nargin<7
    error('Too few input arguments.')
elseif nargin>8
    error('Too many input arguments.')
end
% if nargin==6
%     binwidth=(max-min)/nbins;
%     binedges=linspace(min,max,nbins+1);
%     bincenters=min+binwidth/2:binwidth:max-binwidth/2;
%     
%     averages=NaN(1,nbins);
%     errors=NaN(1,nbins);
% 
%     w = den;
%     y = num ./ (num+den);
%     for i=1:nbins
%         t = (x>binedges(i)&x<binedges(i+1));
%         averages(i)=nansum(y(t).*w(t))./nansum(w(t));
%         errors(i)=nansem(y(t)).*sqrt(oversamplingratio);
%     end
%     
%     
% elseif nargin==7
%     binoverlap=varargin{1};
%     
%     binhalfwidth=(max-min)/nbins*binoverlap/2;
%     bincenters=linspace(min,max,nbins);
%     
%     averages=NaN(1,nbins);
%     errors=NaN(1,nbins);
%     
%     w = den;
%     y = num ./ (num+den);
%     for i=1:nbins
%         t=(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth);
%         averages(i)=nansum(y(t).*w(t))./nansum(w(t));
%         errors(i)=nansem(y(t)).*sqrt(oversamplingratio);
%     end  
% elseif nargin<6
%     error('Too few input arguments.')
% elseif nargin>7
%     error('Too many input arguments.')
% end
% [bincenters,averages,errors] = fracttoratio(bincenters,averages,errors);