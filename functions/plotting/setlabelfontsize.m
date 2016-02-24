function setlabelfontsize(n)
% Set the font size of titles on the current figure

h=get(gca,'title');
set(h,'FontSize',n)

h=get(gca,'xlabel');
set(h,'FontSize',n)

h=get(gca,'ylabel');
set(h,'FontSize',n)
