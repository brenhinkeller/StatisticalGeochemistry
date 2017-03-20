function [bincenters,averages,varargout]=bingeometric(x,y,min,max,oversamplingratio,nbins,varargin)
if nargin==6
    binoverlap = 0;
elseif nargin==7 
    binoverlap=varargin{1}; 
elseif nargin<6
    error('Too few input arguments.')
elseif nargin>7
    error('Too many input arguments.')
end

% Transform to log-space
y = log10(y);

averages=NaN(1,nbins);
errors=NaN(1,nbins);

if binoverlap>1
    binhalfwidth=(max-min)/nbins*binoverlap/2;
    bincenters=linspace(min,max,nbins);

    for i=1:nbins
        averages(i)=nanmean(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth));
        errors(i)=nansem(y(x>bincenters(i)-binhalfwidth&x<bincenters(i)+binhalfwidth)).*sqrt(oversamplingratio);
    end 
else
    binwidth=(max-min)/nbins;
    binedges=linspace(min,max,nbins+1);
    bincenters=min+binwidth/2:binwidth:max-binwidth/2;

    for i=1:nbins
        averages(i)=nanmean(y(x>binedges(i)&x<binedges(i+1)));
        errors(i)=nansem(y(x>binedges(i)&x<binedges(i+1))).*sqrt(oversamplingratio);
    end
end

% Transform back to regular space
if nargout == 3;
    varargout{1} = (abs(10.^averages-10.^(averages-errors)) + abs(10.^(averages+errors)-10.^averages)) / 2;
elseif nargout == 4;
    varargout{1} = 10.^(averages-2*errors); % Lower bound
    varargout{2} = 10.^(averages+2*errors); % Upper bound
end
averages = 10.^averages;
