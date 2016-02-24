function setfigurefontsize(n,varargin)
% Set the font size of all text on the current figure.

h=get(gca,'title');
set(h,'FontSize',n,varargin{:})

h=get(gca,'xlabel');
set(h,'FontSize',n,varargin{:})

h=get(gca,'ylabel');
set(h,'FontSize',n,varargin{:})

set(gca,'FontSize',n,varargin{:})