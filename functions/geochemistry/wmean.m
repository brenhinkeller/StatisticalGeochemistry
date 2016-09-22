function [wx,wsigma,mswd]=wmean(x,sigma)
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
