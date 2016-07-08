function [simaverage, simerror, simratio] = mctaskmelt(data, prob, uncert, meltdata, Liquid_mass, T, P, binedges, nbins)

samplerows=size(data,1);
sdata=NaN(samplerows,size(data,2));

i=1;
while i<samplerows
    % select weighted sample of data
    r=rand(length(prob),1);
    tempdata=data(prob>r,:);
    
    if i+size(tempdata,1)-1<=samplerows
        sdata(i:i+size(tempdata,1)-1,:)=tempdata;
    else
        sdata(i:end,:)=tempdata(1:samplerows-i+1,:);
    end
    i=i+size(tempdata,1);    
end


% Randomize variables over uncertainty interval
sdata=sdata+sdata.*repmat(uncert,size(sdata,1),1).*randn(size(sdata));

% Randomize ages over uncertainty interval
r=randn(size(sdata(:,1)));
ages=sdata(:,2)+r.*sdata(:,1)/2;

% Reshape composition array
composition=NaN(size(sdata,2)-2,size(sdata,1));
for i=1:(size(sdata,2)-2)
    composition(i,:)=sdata(:,i+2)';
end

% Find best-fitting melt percentages
index=zeros(size(composition,2),1);
for i=1:size(composition,2)
    a=repmat(composition(:,i),1,size(meltdata,2));
    [~, index(i)]=min(nansum(((a-meltdata)./a).^2,1));
end

% Populate temporary variables for each of the elements/ratios of interest
param=NaN(size(sdata,1),1,3);
param(:,1,1)=Liquid_mass(index); %Meltestimate
param(:,1,2)=T(index); %Tempestimate
param(:,1,3)=potentialtemperature(T(index)+273.15,P)-273.15; %Mantle potential tempestimate

% Find average values for each quantity of interest for each time bin
simaverage=NaN(1,nbins,size(param,3));
simerror=simaverage;
simratio=size(sdata,1)./size(data,1);
for j=1:nbins

    simaverage(1,j,:)=nanmean(param(ages>binedges(j) & ages<binedges(j+1),:,:),1);
    simerror(1,j,:)=nansem(param(ages>binedges(j) & ages<binedges(j+1),:,:),1);

end

end