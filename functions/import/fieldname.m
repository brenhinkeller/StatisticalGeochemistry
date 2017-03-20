function [textout]=fieldname(text)
text=regexprep(text,'^\s*(.*?)\s*$','$1'); % Remove leading and trailing whitespace
text=regexprep(text,'[^a-zA-Z0-9_]','_'); % Replace any non-alphanumeric charachter with an underscore
textout=regexprep(text,'^([^a-zA-Z])','r$1'); %Replace non-alphanumeric inital character with r