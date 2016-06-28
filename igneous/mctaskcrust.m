function [simaverage, simerror, simratio] = mctaskcrust(data, prob, uncert, binedges, nbins)

% select weighted sample of data
r=rand(length(prob),1);
sdata=data(prob>r,:);

% Randomize variables over uncertainty interval
sdata(:,3)=sdata(:,3)+(sdata(:,3).*uncert(:,3)+3).*randn(size(sdata(:,3)));
sdata(:,4)=sdata(:,4)+(sdata(:,4).*uncert(:,4)+30).*randn(size(sdata(:,4)));


% Randomize ages over uncertainty interval
r=randn(size(sdata(:,1)));
ages=sdata(:,2)+r.*sdata(:,1)/2;

% Calculate temporary variables for each of the elements/ratios of interest
param=NaN(size(sdata,1),1,2);
param(:,1,1)=sdata(:,3); % Crust;
param(:,1,2)=sdata(:,4); % tc1Lith;



% Find average values for each quantity of interest for each time bin
simaverage=NaN(1,nbins,size(param,3));
simerror=simaverage;
simratio=size(sdata,1)./size(data,1);
for j=1:nbins
    simaverage(1,j,:)=nanmean(param(ages>binedges(j) & ages<binedges(j+1),:,:),1);
    simerror(1,j,:)=nansem(param(ages>binedges(j) & ages<binedges(j+1),:,:),1);
end


end