%% Plot spider diagram type plots for REEs



% Pick a silica range
SiO2=65;
% minerals=p.minerals;
minerals={'Garnet','Amphibole','Clinopyroxene','Orthopyroxene','Olivine','Anorthite','Orthoclase','Albite'}; % Major
% minerals={'CaPerovskite','Nepheline','Cordierite','Ilmenite','Biotite','Spinel','Rutile'}; % Minor
% minerals={'Monazite','Allanite','Xenotime','Zircon','Apatite','Sphene'}; % Accessory
% minerals={'Allanite','Zircon','Apatite','Sphene','Orthoclase','Anorthite','Clinopyroxene','Amphibole'}; % Bergell
minerals={'Anorthite','Albite','Orthoclase','Biotite','Amphibole','Garnet','Pyroxene','Olivine'}; % Major

p.minerals = unique([p.minerals; 'Pyroxene']);
p.Pyroxene.elements = p.Orthopyroxene.elements;
for i=1:length(p.Pyroxene.elements)
    e = p.Pyroxene.elements{i};
    p.Pyroxene.(e) = nanmean([p.Orthopyroxene.(e),p.Clinopyroxene.(e)],2);
end
% minerals={'Garnet'};


minerals=minerals(logical(cellfun(@(x) sum(ismember(p.minerals, x)), minerals)));

% elem={'La','Ce','Pr','Nd','Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu'}; % Plain REE
% elem={'La','Ce','Pr','Nd','Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Hf','Y','Sc','Th','U'}; % Bergell suite
% elem={'Rb','Ba','Th','U','K','Nb','Ta','La','Ce','Pb','Nd','Sr','Sm','Zr','Eu','Gd','Ti','Dy','Y','Er','Yb','Lu'}; % Elliott Elements
% elem={'K','Rb','Ba','U','P','Nb','Th','Sr','Zr','Ta','La','Na','Hf','Ce','Ti','Pr','Nd','Eu','Sm','Ga','Gd','Dy','Tb','Ho','Er','Yb','Tm','Lu','V','Y','Zn','Sc','Mn','Co','Ni'};
% elem={'Cs','Rb','K','Na','Li',' ','Ba','Sr','Zn','Mn','Co','Ni',' ','Th','La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Y','Dy','Ho','Er','Tm','Yb','Lu','V','Sc','Cr',' ', 'U','Hf','Zr','Ti',' ','Ta','Nb'};%,'P'

elem={'Rb','Ba','Sr','La','Sm','Yb'};

figure;
c=lines(length(minerals));
trend=NaN(length(minerals),length(elem));
for j=1:length(minerals)
    for i=1:length(elem)
        if isfield(p.Olivine,elem{i})
            trend(j,i)=p.(minerals{j}).(elem{i})(round(SiO2)-40);
        end
    end
    
    ind=1:length(elem);  
    in=ind(~isnan(trend(j,:)));
    tr=trend(j,~isnan(trend(j,:)));
  
  
%     hold on; plot(in,tr,'.-','Color',c(j,:)) % Interpolate through missing elements
    hold on; plot(ind,trend(j,:),'.-','Color',c(j,:),'MarkerSize',10) % Skip missing elements
    
%     f=polyfit(in,tr,2);
%     hold on; plot(ind, f(1).*ind.^2 + f(2).*ind + f(3), 'Color', c(j,:))
end

set(gca,'XTick',1:length(elem))
set(gca,'XTickLabel',elem)

yt=floor(min(get(gca,'ylim'))):ceil(max(get(gca,'ylim')));
set(gca,'YTick',yt);
set(gca,'YTickLabel',10.^yt);
ylabel('Mineral/Melt Partition Coefficient');
xlim([1 length(elem)])
legend(minerals)


%% Choose ordering
test = sortrows([num2cell(nanmean(trend,1)'), elem']);
elem = test(:,2)';

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

%% Plot kd vs SiO2 for various minerals.

% Pick a silica range
SiO2=65;
% minerals=p.minerals;
minerals={'Garnet','Clinopyroxene','Magnetite','Ilmenite','Amphibole','Biotite'}; % Major
% minerals={'CaPerovskite','Nepheline','Cordierite','Ilmenite','Biotite','Spinel','Rutile'}; % Minor
% minerals={'Monazite','Allanite','Xenotime','Apatite','Sphene'}; % Accessory
% minerals={'Allanite','Zircon','Apatite','Sphene','Orthoclase','Anorthite','Clinopyroxene','Amphibole'}; % Bergell
% minerals={'Anorthite','Albite','Orthoclase','Biotite','Amphibole','Garnet','Pyroxene','Olivine'}; % Major

p.minerals = unique([p.minerals; 'Pyroxene']);
p.Pyroxene.elements = p.Orthopyroxene.elements;
for i=1:length(p.Pyroxene.elements)
    e = p.Pyroxene.elements{i};
    p.Pyroxene.(e) = nanmean([p.Orthopyroxene.(e),p.Clinopyroxene.(e)],2);
end


minerals=minerals(logical(cellfun(@(x) sum(ismember(p.minerals, x)), minerals)));

elem='Zr';

figure;
c=lines(length(minerals));
trend=NaN(length(minerals),length(elem));
for j=1:length(minerals)

  
    hold on; plot(p.SiO2,10.^p.(minerals{j}).(elem),'.-','Color',c(j,:),'MarkerSize',10) % Skip missing elements
    

end

xlabel('SiO2')

ylabel('Estimated average mineral/melt Kd');
legend(minerals)
title(['Selected mineral/melt ' elem ' partition coefficients'])
formatfigure
