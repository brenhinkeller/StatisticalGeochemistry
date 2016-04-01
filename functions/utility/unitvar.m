function y = unitvar(x,varargin)
% Divide a variable by its standard deviation, to set var=1
s=sqrt(nanvar(x,0,varargin{:}));
if length(m)==1;
    y=x./s;
else
    y=x./repmat(s,size(x)./size(s));
end