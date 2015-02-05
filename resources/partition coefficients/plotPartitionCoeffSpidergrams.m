%% Plot spider diagram type plots for REEs



% Pick a silica range
SiO2=70;
% minerals=p.minerals;
minerals={'Garnet','Amphibole','Clinopyroxene','Orthopyroxene','Olivine','Anorthite','Orthoclase','Albite'};
minerals={'Monazite','Allanite','Xenotime','Zircon','Apatite','Sphene'};

minerals=minerals(logical(cellfun(@(x) sum(ismember(p.minerals, x)), minerals)));


elem={'La','Ce','Pr','Nd','Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Hf','Y','Sc','Th','U'};

figure;
c=lines(length(minerals));
for j=1:length(minerals)
    trend=NaN(1,length(elem));
    for i=1:length(elem)
        trend(i)=p.(minerals{j}).(elem{i})(round(SiO2)-40);
    end
    
    ind=1:length(elem);
    
    ind=ind(~isnan(trend));
    trend=trend(~isnan(trend));
    
    f=polyfit(ind,trend,2);
    
    
    hold on; plot(ind,trend,'.-','Color',c(j,:))
%     hold on; plot(ind, f(1).*ind.^2 + f(2).*ind + f(3), 'Color', c(j,:))

end

set(gca,'XTick',1:length(elem))
set(gca,'XTickLabel',elem)

yt=floor(min(get(gca,'ylim'))):ceil(max(get(gca,'ylim')));
set(gca,'YTick',yt);
set(gca,'YTickLabel',10.^yt);
ylabel('Mineral/Melt Partition Coefficient');

legend(minerals)



%% Plot 3d trends for REEs
figure; hold on;
elem={'La','Ce','Pr','Nd','Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb'};
for i=1:length(elem)
    plot3(i*ones(41,1),40:80,10.^p.Garnet.(elem{i}))
end

set(gca,'XTick',1:length(elem))
set(gca,'XTickLabel',elem)


%% Plot spider diagram type plots for REEs
elem={'La','Ce','Pr','Nd','Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb'};
trend=NaN(1,length(elem));
for i=1:length(elem)
    trend(i)=10.^nanmean(p.Garnet.(elem{i}));
end

ind=1:length(elem);

ind=ind(~isnan(trend));
trend=trend(~isnan(trend));

f=polyfit(ind,trend,2);


figure; plot(ind,trend,'.')
hold on; plot(ind, f(1).*ind.^2 + f(2).*ind + f(3))
% hold on; plot(ind, f(1).*ind + f(2))
set(gca,'XTick',1:length(elem))
set(gca,'XTickLabel',elem)
title('Garnet')

%% Delete promethium
for j=1:length(p.minerals)
    p.(p.minerals{j}).Pm(:)=NaN;
end
