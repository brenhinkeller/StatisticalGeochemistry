function c = interpColor(cmap,n)
    cNum = size(cmap,1);
    c = interp1(1:cNum,cmap,linspace(1,cNum,n));
end