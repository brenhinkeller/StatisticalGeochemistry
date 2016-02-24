function [a, sa, b, sb, mswd]=yorkfit(x,sx,y,sy)
% [a sa b sb]=yorkfit(x,sx,y,sy)
% Uses the York(1969) fit to calculate a,b, and uncertanties 
% sa, sb for the equation y=a+bx

%% Ordinary linear regression (to get a first estimate of slope and intercept)

% Make sure the input variables are the right dimensions
x=x(:);
y=y(:);
sx=sx(:);
sy=sy(:);

hasdata=~isnan(x)&~isnan(y)&~isnan(sx)&~isnan(sy);
x=x(hasdata);
y=y(hasdata);
sx=sx(hasdata);
sy=sy(hasdata);

% Calculate the ordinary least-squares fit
g=[ones(size(x)) x];
% For the equation y=a+bx, m(1)=a, m(2)=b
m=(g'*g)\g'*y;

b=m(2);
a=m(1);

%% Now, let's define parameters needed by the York fit

% Weighting factors
wx=1./sx.^2;

wy=1./sy.^2;

% terms that don't depend on a or b
alpha=sqrt(wx.*wy);

r=sum((x-mean(x)).*(y-mean(y))) ./ ( sqrt(sum((x-mean(x)).^2)) .* sqrt(sum((x-mean(x)).^2)) );


%% Perform the York fit (must iterate)
% deltab=1;
% first=figure;
% plot(x,y,'.')
% second=figure;
for i=1:10  
    z= wx.*wy ./ (b^2*wy +wx -2*b*r.*alpha);
    
    Xm=sum(z.*x) ./ sum(z);
    Ym=sum(z.*y) ./ sum(z);
    
    U=x-Xm;
    V=y-Ym;
    
    b=sum(z.^2 .* V .* (U./wy + b.*V./wx - (b.*U +V).*r./alpha)) ./...
        sum(z.^2 .* U .* (U./wy + b.*V./wx - (b.*U +V).*r./alpha));
    
    a=Ym-b.*Xm;
    hold on; plot(40:80,a+b*(40:80))
end


%% Calculate uncertainties
bp=z.*(U./wy + b.*V./wx - (b.*U+V).*r./alpha);

u=Xm+bp;
v=Ym+b.*bp;

xm=sum(z.*u)./sum(z);
ym=sum(z.*v)./sum(z);

sb=sqrt(1./sum(z.*(u-xm).^2));
sa=sqrt(1./sum(z)+xm.^2.*sb.^2);


%% Calculate MSWD of the fit

mswd=1./length(x).*sum( (y-a-b.*x).^2 ./ (sy.^2+b.^2.*sx.^2) );


%% Print results

sprintf('y=a+bx:\n a= %.8g +/- %3.2g \n b= %.8g +/- %3.2g \n mswd= %.2g',a,sa,b,sb,mswd)

