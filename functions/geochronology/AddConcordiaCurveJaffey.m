%% Add Jaffey concordia curve with uncertainty

% Jaffey decay constants
    l235U = log(2)/(7.0381*10^8); % 1/Years
    l235U_sigma = log(2)/(7.0381*10^8)*0.0048/7.0381; % 1/Years
    l238U = log(2)/(4.4683*10^9); % 1/Years
    l238U_sigma = log(2)/(4.4683*10^9)*0.0024/4.4683; % 1/Years
    
    % Uncertainty of 235 decay constant relative to the 238 decay constant
    l235U_sigma_r = l235U .* sqrt((l238U_sigma/l238U).^2 + (l235U_sigma/l235U).^2); % 1/Years
    
% Schoene adjusted 235U decay constant
    l235U_Schoene = 9.8569E-10; % 1/Years
        
% Plot the concordia curve
    xl = xlim; % Note current size of figure
    tlim = log(xl+1)./l235U; % Calculate time range of current window
    t = linspace(tlim(1),tlim(2),1000); % Time vector
    r75t = exp(l235U.*t) - 1; % X axis values
    r68t = exp(l238U.*t) - 1; % Y axis values
    hold on; fill([exp((l235U-l235U_sigma_r*2).*t) - 1, fliplr(exp((l235U+l235U_sigma_r*2).*t) - 1)],[r68t, fliplr(r68t)],'k','FaceAlpha',0.2,'EdgeAlpha',0) % Two-sigma concordia uncertainty
    hold on; plot(r75t,r68t,'k') % Concordia line

    xlim(xl); % Ensure that figure size hasn't changed
    
% Calculate desired range of age markers
    scale=floor(log10(range(tlim))); % Characteristic timescale (order of magnitude)
    trange = round(tlim/10.^scale); % Minimum and maximum time to a round number
    majorstep = 0.25;
    tticks = (trange(1):majorstep:trange(2)).*10^scale; % Time ticks, to a round number
    r75tticks = exp(l235U.*tticks) - 1; % X axis values
    r68tticks = exp(l238U.*tticks) - 1; % Y axis values

% Plot age markers with text labels
    hold on; plot(r75tticks,r68tticks,'.k','MarkerSize',12)
    ticklabels = cellfun(@num2str, num2cell(tticks/10^6),'UniformOutput',false);
    xoffset = range(xlim)/200;
    yoffset = range(ylim)/100;
    test = (r75tticks-xoffset)>(xl(1)+8*xoffset) & r75tticks < xl(2);
    hold on; text(r75tticks(test)-xoffset,r68tticks(test)+yoffset,ticklabels(test),'HorizontalAlignment','right')
  
    fig = gcf;
    warning('off', 'MATLAB:print:FigureTooLargeForPage')
    fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
    set(fig,'renderer','painters')
    