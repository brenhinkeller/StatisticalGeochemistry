if ~exist('mcigncn1','var')
    load mcigncn1
end
if ~exist('igncn1','var')
    load igncn1
end

agemin = 0;
agemax = 3900;
nbins = 39;

plotmin = 0;
plotmax = 4000;

Elems={'K2O','Na2O','TiO2','P2O5','Al2O3','FeOT','MnO','MgO','Ni'};

yrange = struct;
% yrange.FeOT = [2,14];
% yrange.Ni = [0,350];
% yrange.P2O5 = [0.06,0.33];
% yrange.Al2O3 = [12.6,16];

% Silica range to plot
% rsi=[43,78];

rsi=[43,55,65,78];

% Figure prettifying details
yAxisMin = 0.05;
yAxisTotal = 0.93;
h = figure('Position',[0, 1000, 500, 1000]); 
ax0 = axes('Position', [0.11, yAxisMin, 0.78, yAxisTotal],'Ytick',[],'XLim',[plotmin plotmax]/1000,'XDir','Reverse','Box','on');
xlabel('Age (Ga)');
formatfigure;
nfigs = length(Elems);

yAxisCurrent = yAxisMin;
yOverlap = 1.3;
yAxisHeight = yOverlap*yAxisTotal/nfigs;
yAxisOffset = (yAxisTotal-yAxisHeight)/(nfigs-1);

colors = lines(nfigs);
data = struct;
for j = 1:nfigs
    Elem = Elems{j};
    
%     test=mcigncn1.SiO2>rsi(1)&mcigncn1.SiO2<rsi(end)&mcigncn1.Elevation>-100&~isnan(mcigncn1.(Elem));
%     [c,m,e]=bincumulative(mcigncn1.Age(test),mcigncn1.(Elem)(test),agemin,agemax,length(mcigncn1.SiO2)./length(igncn1.SiO2),nbins);
%     [c,m,e]=bin(mcigncn1.Age(test),mcigncn1.(Elem)(test),agemin,agemax,length(mcigncn1.SiO2)./length(igncn1.SiO2),nbins);

    % Cumulative with modern proportions
    m = zeros(1,nbins);
    e = zeros(1,nbins);
    for i=1:length(rsi)-1
        test=mcigncn1.SiO2>rsi(i)&mcigncn1.SiO2<rsi(i+1)&mcigncn1.Elevation>-100&~isnan(mcigncn1.(Elem));
%         [c,m1,e1]=bincumulative(mcigncn1.Age(test),mcigncn1.(Elem)(test),agemin,agemax,length(mcigncn1.SiO2)./length(igncn1.SiO2),nbins);
        [c,m1,e1]=bin(mcigncn1.Age(test),mcigncn1.(Elem)(test),agemin,agemax,length(mcigncn1.SiO2)./length(igncn1.SiO2),nbins);

        prop = sum(mcigncn1.SiO2>rsi(i)&mcigncn1.SiO2<rsi(i+1)&mcigncn1.Elevation>-100)./sum(mcigncn1.SiO2>rsi(1)&mcigncn1.SiO2<rsi(end)&mcigncn1.Elevation>-100);
        m = m + prop.*m1;
        e = e + prop.*e1;
    end
%     e = e./sqrt(i); % Standard error
%     continentDist = linspace((4000-c(end))/4000,c(1)/4000,length(m));
%     m = fliplr(cumsum(fliplr(m).*continentDist)./cumsum(continentDist));
%     e = fliplr(cumsum(fliplr(e).*continentDist)./cumsum(continentDist)./sqrt(cumsum(1:length(e))));
    
    % Prepare axis
    ax.(Elem) = axes('Position',[0.11, yAxisCurrent, 0.78, yAxisHeight]);
    
    % Plot data
    errorbar(c/1000,m,2*e,'.','Color',colors(j,:))
    data.Age = c;
    data.(Elem) = m;
    data.([Elem '_sigma']) = e;
    
    % Clean up axes
    if isfield(yrange,Elem)
        ylim(yrange.(Elem));
    end
    ylabel(Elem); % Set y-axis label
    formatfigure; % Set font sizes
    ax.(Elem).Box = 'off'; % Turn off bounding box with unwanted tick-marks
    ax.(Elem).YColor = colors(j,:); % Set y-axis color to match timeseries
    ax.(Elem).XLim = [plotmin plotmax]/1000; % Check timescale
    ax.(Elem).XDir = 'reverse'; % Time to right
    ax.(Elem).Color = 'none'; % Make transparent
    ax.(Elem).XAxis.Visible = 'off'; % No x axis
    
    % Move every-other axis to right hand side of figure
    if mod(j,2)==0
        ax.(Elem).YAxisLocation = 'right';
    end

    yAxisCurrent = yAxisCurrent + yAxisOffset;
end

fig = gcf;
fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
saveas(gcf,[num2str(rsi(1)) '-' num2str(rsi(end)) '% SiO2ConstantProportion.pdf'])

data.elements = fieldnames(data);
exportdataset(data,[num2str(rsi(1)) '-' num2str(rsi(2)) '%SiO2ConstantProportion.csv'],',')



%% Ratios
% if ~exist('mcigncn1','var')
%     load mcigncn1
% end
% if ~exist('igncn1','var')
%     load igncn1
% end
% 
% agemin = 0;
% agemax = 4000;
% nbins = 8;
% 
% plotmin = 0;
% plotmax = 4000;
% 
% 
% % Nums={'Cr','Ni','Lu','Nd','Rb',};
% % Dens={'U','Co','Hf','Sm','Sr',};
% Nums={'Cr','Rb',};
% Dens={'U','Sr',};
% logscale = [1 0];
% cumulative = [1 0];
% 
% yrange = struct;
% 
% rsi=[43,55,65,78];
% 
% % Figure-prettifying details
% yAxisMin = 0.09;
% yAxisTotal = 0.9;
% h = figure('Position',[0, 1000, 500, 600]); 
% ax0 = axes('Position', [0.11, yAxisMin, 0.78, yAxisTotal],'Ytick',[],'XLim',[plotmin plotmax]/1000,'XDir','Reverse','Box','on');
% xlabel('Age (Ga)');
% formatfigure;
% nfigs = length(Nums);
% 
% yAxisCurrent = yAxisMin;
% yOverlap = 0.95;
% yAxisHeight = yOverlap*yAxisTotal/nfigs;
% yAxisOffset = (yAxisTotal-yAxisHeight)/(nfigs-1);
% 
% colors = lines(nfigs);
% data = struct;
% for j = 1:nfigs
%     Num = Nums{j};
%     Den = Dens{j};
%     
% %     test = mcigncn1.SiO2>rsi(1) &mcigncn1.SiO2<rsi(end) &mcigncn1.Elevation>-100 & mcigncn1.(Num)>0 & mcigncn1.(Den)>0;
% %     [c,m,e]=binmedians(mcigncn1.Age(test),log10(mcigncn1.(Num)(test)./mcigncn1.(Den)(test)),agemin,agemax,length(mcigncn1.SiO2)./length(igncn1.SiO2),nbins);
% %     [c,m,e]=binmedians(mcigncn1.Age(test),(mcigncn1.(Num)(test)./mcigncn1.(Den)(test)),agemin,agemax,length(mcigncn1.SiO2)./length(igncn1.SiO2),nbins);
% 
%     % Cumulative with modern proportions
%     m = zeros(1,nbins);
%     e = zeros(1,nbins);
%     for i=1:length(rsi)-1
%         test = mcigncn1.SiO2>rsi(i) & mcigncn1.SiO2<rsi(i+1) & mcigncn1.Elevation>-100 & mcigncn1.(Num)>0 & mcigncn1.(Den)>0;
%         [c,m1,e1]=binmedians(mcigncn1.Age(test),(mcigncn1.(Num)(test)./mcigncn1.(Den)(test)),agemin,agemax,length(mcigncn1.SiO2)./length(igncn1.SiO2),nbins);
% 
%         prop = sum(mcigncn1.SiO2>rsi(i)&mcigncn1.SiO2<rsi(i+1)&mcigncn1.Elevation>-100)./sum(mcigncn1.SiO2>rsi(1)&mcigncn1.SiO2<rsi(end)&mcigncn1.Elevation>-100);
% %         relativeConcentration = nanmean(mcigncn1.(Den)(mcigncn1.SiO2>rsi(i)&mcigncn1.SiO2<rsi(i+1)&mcigncn1.Elevation>-100))./nanmean(mcigncn1.(Den)(mcigncn1.SiO2>rsi(1)&mcigncn1.SiO2<rsi(end)&mcigncn1.Elevation>-100));
% %         m = m + prop.*m1.*relativeConcentration;
% %         e = e + prop.*e1.*relativeConcentration;
%         m = m + prop.*m1;
%         e = e + prop.*e1;
%     end
%     if cumulative(j)
%         continentDist = linspace((4000-c(end))/4000,c(1)/4000,length(m));
%         m = fliplr(cumsum(fliplr(m).*continentDist)./cumsum(continentDist));
%         e = fliplr(cumsum(fliplr(e).*continentDist)./cumsum(continentDist)./cumsum(1:length(e)));
%     end
%     
%     % Prepare axis
%     ax.([Num Den]) = axes('Position',[0.11, yAxisCurrent, 0.78, yAxisHeight]);
%     
%     % Plot data
%     errorbar(c/1000,m,2*e,'.-','Color',colors(j,:))
%     data.Age = c;
%     data.([Num Den]) = m;
%     data.([[Num Den] '_sigma']) = e;
%     
%     % Clean up axes
%     if isfield(yrange,[Num Den])
%         ylim(yrange.([Num Den]));
%     end
%     ylabel([Num Den]); % Set y-axis label
%     formatfigure; % Set font sizes
%     ax.([Num Den]).Box = 'off'; % Turn off bounding box with unwanted tick-marks
%     ax.([Num Den]).YColor = colors(j,:); % Set y-axis color to match timeseries
%     ax.([Num Den]).XLim = [plotmin plotmax]/1000; % Check timescale
%     ax.([Num Den]).XDir = 'reverse'; % Time to right
%     ax.([Num Den]).Color = 'none'; % Make transparent
%     ax.([Num Den]).XAxis.Visible = 'off'; % No x axis
%     
%     % Move every-other axis to right hand side of figure
%     if mod(j,2)==0
%         ax.([Num Den]).YAxisLocation = 'right';
%     end
%     
%     % Set log scale if desired
%     if logscale(j)
%         ax.([Num Den]).YScale = 'log'
%     end
%     
%     yAxisCurrent = yAxisCurrent + yAxisOffset;
% end
% 
% saveas(gcf,[num2str(rsi(1)) '-' num2str(rsi(end)) '% SiO2Ratios.pdf'])

