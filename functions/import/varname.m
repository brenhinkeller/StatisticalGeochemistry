function [textout]=varname(text)
text=regexprep(text,'wt%','');
text=regexprep(text,'\(.*\)','');
text=regexprep(text,'[^a-zA-Z0-9_]','');
textout=regexprep(text,'^([^a-zA-Z])','r$1');