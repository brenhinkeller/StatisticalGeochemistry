function [x_,s2x_,mswd]=wmean(x,s2x)
x=x(:);
sx=s2x(:)./2; %(Divide by 2, assuming the input errors are 2-sigma)
w=1./sx.^2;
x_=sum(w.*x)./sum(w);
mswd=1./(length(x)-1).*sum((x-x_).^2./sx.^2);
s2x_=2*sqrt(1/sum(1./sx).*mswd); % Return 2-sigma errors
% %print the results:
% xsigfigs=floor(log10(x_))-floor(log10(sx_))+1;
% eval(['sprintf(''weighted mean, with 2-sigma uncertainty:\n x_= %' ...
%     num2str(xsigfigs+2) '.' num2str(xsigfigs+1) ...
%     'g +/- %3.2g \n mswd= %.2g'',x_,2.*sx_,mswd)'])