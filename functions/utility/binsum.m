function [sums,bincenters]=binsum(x,y,binedges)
% [bincenters,averages,errors,varargout]=bin(x,y,min,max,oversamplingratio,nbins,varargin)
% Return the average values for independent variable y binned as a funciton 
% of independent variable x.

if nargin<3
    error('Too few input arguments.')
elseif nargin>3
    error('Too many input arguments.')
end

bincenters = center(binedges);
sums = NaN(size(bincenters));
nbins = length(binedges)-1;

for i=1:nbins
    sums(i)=nansum(y(x>binedges(i)&x<binedges(i+1)));

end