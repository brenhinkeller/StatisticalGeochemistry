function [bincenters,averages,errors,varargout]=bin(x,y,min,max,oversamplingratio,nbins,varargin)
% [bincenters,averages,errors,varargout]=bin(x,y,min,max,oversamplingratio,nbins,varargin)
% Return the average values for independent variable y binned as a funciton 
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
xerrors=NaN(1,nbins);

if binoverlap>1
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);

    for i=1:nbins
        t = x>(bincenters(i)-binhalfwidth) & x<(bincenters(i)+binhalfwidth) & ~isnan(y);
        averages(i)=mean(y(t));
        errors(i)=std(y(t)).*sqrt(oversamplingratio/sum(t));
        xerrors(i)=bincenters(i)-mean(x(t));
    end 
    if nargout == 4
        varargout{1} = xerrors;
    end
else
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;

    for i=1:nbins
        t = x>binedges(i) & x<binedges(i+1) & ~isnan(y);
        averages(i)=mean(y(t));
        errors(i)=std(y(t)).*sqrt(oversamplingratio/sum(t));
        xerrors(i)=bincenters(i)-mean(x(t));
    end
    if nargout == 4
        varargout{1} = xerrors;
    end
end