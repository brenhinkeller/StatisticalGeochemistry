function [wx,wsigma,mswd]=wmean(x,sigma,varargin)
% [wx,wsigma,mswd]=wmean(x,sigma,[w],'print')
% Calculate a simple weighted mean and mswd for the data in x with
% uncertainty sigma

% Remove NaNs
    t = isnan(x)|isnan(sigma);
    x = x(~t);
    sigma = sigma(~t);

% Calculate weighted mean
    if length(x) == 1
        wx = x;
        wsigma = sigma;
        mswd = 0;
    else
        % User-supplied weight
        if nargin>2 && isnumeric(varargin{1})
            w = varargin{1}(~t);
            wx=sum(w.*x)./sum(w);
            mswd=1/(length(x)-1)*sum((x-wx).^2./sigma.^2);
%             if (mswd>1);
%                 wsigma=sum(w.*sigma)./sum(w).*sqrt(mswd);
%             else
%                 wsigma=sum(w.*sigma)./sum(w);
%             end
            wsigma=max(sum(w.*sigma)./sum(w), nanstd(x,w));
            
        % Weight by variance
        else
            w=1./(sigma.*sigma);
            wx=sum(w.*x)./sum(w);
            mswd=1./(length(x)-1).*sum((x-wx).^2./sigma.^2);
            wsigma=sqrt(1./sum(w).*mswd);
        end
    end


% Print results
    if nargin > 2 && any(strcmp(varargin,'print'))
        fprintf('Weighted Mean:\n mu= %.8g +/- %.3g \n mswd= %.3g\n\n',wx,wsigma,mswd)
    end