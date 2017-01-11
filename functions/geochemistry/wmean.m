function [wx,wsigma,mswd]=wmean(x,sigma)
% [wx,wsigma,mswd]=wmean(x,sigma)
% Calculate a simple weighted mean and mswd for the data in x with
% uncertainty sigma

if length(x) == 1
    wx = x;
    wsigma = sigma;
    mswd = 0;
else
    w=1./(sigma.*sigma);
    wx=sum(w.*x)./sum(w);
    mswd=1./(length(x)-1).*sum((x-wx).^2./sigma.^2);
    wsigma=sqrt(1/sum(w).*mswd);
end
