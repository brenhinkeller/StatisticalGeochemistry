function [bincenters,averages,errors,N]=binN(x,y,min,max,oversamplingratio,nbins,varargin)
if nargin==6
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;
    
    averages=NaN(1,nbins);
    errors=NaN(1,nbins);
    N=NaN(1,nbins);

    for i=1:nbins
        averages(i)=nanmean(y(x>binedges(i)&x<binedges(i+1)));
        errors(i)=nansem(y(x>binedges(i)&x<binedges(i+1))).*sqrt(oversamplingratio);
        N(i)=sum(x>binedges(i)&x<binedges(i+1));
    end
    
    
elseif nargin==7
    binoverlap=varargin{1};
    
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);
    
    averages=NaN(1,nbins);
    errors=NaN(1,nbins);
    N=NaN(1,nbins);

    for i=1:nbins
        averages(i)=nanmean(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth));
        errors(i)=nansem(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth)).*sqrt(oversamplingratio);
        N(i)=sum(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth);
    end  
elseif nargin<6
    error('Too few input arguments.')
elseif nargin>7
    error('Too many input arguments.')
end
