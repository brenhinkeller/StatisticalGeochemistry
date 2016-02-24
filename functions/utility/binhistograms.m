function [s,bincenters]=binhistograms(x,y,xmin,xmax,ymin,ymax,nxbins,nybins)

binwidth=(xmax-xmin)/nxbins;
binedges=linspace(xmin,xmax,nxbins+1);
bincenters=xmin+binwidth/2:binwidth:xmax-binwidth/2;

ytest=y>ymin&y<ymax;
s=struct;
for i=1:nxbins 
    [s(i).n,s(i).ybincenters]=hist(y(x>binedges(i)&x<binedges(i+1)&ytest),nybins);
end
