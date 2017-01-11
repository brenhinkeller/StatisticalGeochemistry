function [textout]=fieldname(text)
text=regexprep(text,'[^a-zA-Z0-9_]','_');
textout=regexprep(text,'^([^a-zA-Z])','r$1');