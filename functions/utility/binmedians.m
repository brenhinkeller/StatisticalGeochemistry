function [bincenters,averages,errors]=binmedians(x,y,min,max,oversamplingratio,nbins,varargin)
% [bincenters,averages,errors]=bin(x,y,min,max,oversamplingratio,nbins,varargin)
% Return the median values for independent variable y binned as a funciton 
% of independent variable x.

if nargin==6
    binoverlap = 0;
elseif nargin==7 
    binoverlap=varargin{1}; 
elseif nargin<6
    error('Too few input arguments.')
elseif nargin>7
    error('Too many input arguments.')
end

averages=NaN(1,nbins);
errors=NaN(1,nbins);

if binoverlap>1
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);
    
    for i=1:nbins
        averages(i)=nanmedian(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth));
%         errors(i)=nansem(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth)).*sqrt(oversamplingratio); % Standard error of the mean
        errors(i)=nanmsem(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth)).*sqrt(oversamplingratio); % Standard error of the median (MAD/sqrt(n))
    end 
else
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;

    for i=1:nbins
        averages(i)=nanmedian(y(x>binedges(i)&x<binedges(i+1)));
%         errors(i)=nansem(y(x>binedges(i)&x<binedges(i+1))).*sqrt(oversamplingratio); % Standard error of the mean
        errors(i)=nanmsem(y(x>binedges(i)&x<binedges(i+1))).*sqrt(oversamplingratio); % Standard error of the median (MAD/sqrt(n))
    end
end