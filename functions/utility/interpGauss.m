function yq=interpGauss(x,y,xq,sigma,varargin)
% Flatten array
xf = x(:);
yf = y(:);
yq=zeros(size(xq));
xq = xq(:);

if nargin>4 && strcmp(varargin{:},'mirror')
    % Mirror your X values to deal with the ends
    xmin = min(xf);
    xmax = max(xf);
    xmid = median(xf);
    ymir = [yf(xf<xmid);yf;yf(xf>xmid)];f
    xmir = [xmin-(xf(xf<xmid)-xmin);xf;xmax+(xmax-xf(xf>xmid))];
    
    for i=1:length(xq)
        w = 1./sqrt(2*sigma^2*pi).*exp(-(xmir-xq(i)).^2./(2*sigma^2));
        yq(i)=sum(ymir.*w)./sum(w);
    end
else
    for i=1:length(xq)
        t = abs(xf-xq(i))<(33*sigma);
        if sum(t)>0;
            w = 1./sqrt(2*sigma^2*pi).*exp(-(xf(t)-xq(i)).^2./(2*sigma^2));
            yq(i)=sum(yf(t).*w)./sum(w);
        end
    end
end