function formatfigure(varargin) 
    % Format figure font size to appropriate standards for 
    % inclusion in a paper or problem set report

    if nargin==0  
       % If no graphics handle is specified
       ax = gca();
    else
       % If a graphics handle is specified
       ax = varargin{1};
    end

    % Set font size of figure title
    h=get(ax,'title');
    set(h,'FontSize',16)            

    % Set font size of x label
    h=get(ax,'xlabel');
    set(h,'FontSize',16)           

    % Set font size of y label
    h=get(ax,'ylabel');
    set(h,'FontSize',16)            

    % Set font size of all other text
    set(ax,'FontSize',14)  

    % Crop figure to scale
    fig = gcf();
    warning('off', 'MATLAB:print:FigureTooLargeForPage')
    fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];

    % Ensure vector output
    set(fig,'renderer','painters')

end