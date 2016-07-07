function [simaverage, simerror, simratio] = mctask(data, prob, uncert, binedges, nbins)

% select weighted sample of data
r=rand(length(prob),1);
sdata=data(prob>r,:);

% Randomize variables over uncertainty interval
sdata=sdata+sdata.*repmat(uncert,size(sdata,1),1).*randn(size(sdata));

% Randomize ages over uncertainty interval
r=randn(size(sdata(:,1)));
ages=sdata(:,2)+r.*sdata(:,1)/2;

% Fill temporary variables with each of the elements of interest
param=NaN(size(sdata,1),1,size(sdata,2)-2);
for i=1:(size(sdata,2)-2)
    param(:,1,i)=sdata(:,i+2);
end

% Find average values for each quantity of interest for each time bin
simaverage=NaN(1,nbins,size(param,3));
simerror=simaverage;
simratio=size(sdata,1)./size(data,1);
for j=1:nbins
    simaverage(1,j,:)=nanmean(param(ages>binedges(j) & ages<binedges(j+1),:,:),1);
    simerror(1,j,:)=nansem(param(ages>binedges(j) & ages<binedges(j+1),:,:),1);
end

end