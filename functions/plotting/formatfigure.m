function formatfigure(varargin) %Format figure font size to 
% appropriate standards for inclusion in a problem set report

if nargin==0;   %If no graphics handle is specified
    h=get(gca,'title');
    set(h,'FontSize',16)    %Set font size of figure title
    
    h=get(gca,'xlabel');
    set(h,'FontSize',16)    %Set font size of x label
    
    h=get(gca,'ylabel');
    set(h,'FontSize',16)    %Set font size of y label
    
    set(gca,'FontSize',14)  %Set font size of all other text
    
else            %If a graphics handle is specified
    h=get(varargin{:},'title');
    set(h,'FontSize',16)            %Set font size of figure title
    
    h=get(varargin{:},'xlabel');
    set(h,'FontSize',16)            %Set font size of x label
    
    h=get(varargin{:},'ylabel');
    set(h,'FontSize',16)            %Set font size of y label
    
    set(varargin{:},'FontSize',14)  % Set font size of all other text
    
end