function [binmeans, bincenters]=monteCarloFit(x,sx,y,sy,xmin,xmax,nbins,binw)
% [binmeans bincenters]=monteCarloFit(x,sx,y,sy,xmin,xmax,nbins,binw)
% Run a simplified Monte Carlo fit with nbins of witdth binw between xmin and xmax
% You can set either binw or nbins to 0 to calculate default bin spacings.


% figure out useful bin configuration if not provided
if binw==0 && nbins==0;
    nbins=10;
end

if binw==0 && nbins~=0;
    binw=abs(xmax-xmin)/(nbins-1);
elseif nbins==0 && binw~=0;
    nbins=abs(xmax-xmin)/binw+1;
end


% Fill in variances where not provided explicitly
sx(isnan(sx)&~isnan(x))=nanvar(x);
sy(isnan(sy)&~isnan(y))=nanvar(y);

% Remove NaN data
hasdata=~isnan(x)&~isnan(y)&~isnan(sx)&~isnan(sy);
x=x(hasdata);
y=y(hasdata);
sx=sx(hasdata);
sy=sy(hasdata);

% Increase x uncertainty if x sampling is sparse
xsorted=sort(x);
minerr=max(xsorted(2:end)-xsorted(1:end-1));
sx(sx<minerr/2)=minerr/2;

% Run the Monte Carlo
halfw=binw/2;
bincenters=xmin:(xmax-xmin)/(nbins-1):xmax;

nsims=round(1000000/length(x));
xm=repmat(x,nsims,1)+randn(size(x).*[nsims 1]).*repmat(sx,nsims,1);
ym=repmat(y,nsims,1)+randn(size(y).*[nsims 1]).*repmat(sy,nsims,1);

binmeans=NaN(nbins,1);
for i=1:nbins
    binmeans(i)=nanmean(ym(xm>(bincenters(i)-halfw)&xm<(bincenters(i)+halfw)));
end

end


