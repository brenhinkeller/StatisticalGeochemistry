function y=smoothGauss(x,y,sigma,varargin)
% Flatten array
xf = x(:);
yf = y(:);
y = NaN(size(x));

if nargin>3 && strcmp(varargin{:},'mirror')
    % Mirror your X values to deal with the ends
    xmin = min(xf);
    xmax = max(xf);
    xmid = median(xf);
    ymir = [yf(xf<xmid);yf;yf(xf>xmid)];f
    xmir = [xmin-(xf(xf<xmid)-xmin);xf;xmax+(xmax-xf(xf>xmid))];
    
    for i=1:length(xf)
        w = 1./sqrt(2*sigma^2*pi).*exp(-(xmir-xf(i)).^2./(2*sigma^2)); % sample weights
        y(i)=sum(ymir.*w)./sum(w);
    end
else
    for i=1:length(xf)
        w = 1./sqrt(2*sigma^2*pi).*exp(-(xf-xf(i)).^2./(2*sigma^2)); % sample weights
        y(i)=sum(yf.*w)./sum(w);
    end
end