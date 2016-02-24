function [dataout]=importc(filename,varargin)
% [data]=import(filename, delimiter, difficulty)
% Import arbitrary delimited ASCII data into a cell array

% If the requested file exists on the path, open it; otherwise return an error
if exist(filename,'file')==2
    fid=fopen(filename);
    data=textscan(fid,'%s','Delimiter','\n');
    data=data{1};
    fclose(fid);
else error([filename ' does not exist on path.'])
end


if nargin==2;
    % Use provided delimiter
    delimiter=varargin{1};
    % Convert '\t' to a tab character
    if all(delimiter=='\t'); delimiter='	'; end
else
    % A number of standard delimiters to choose from (tab, comma, ...)
    delims='	,;| ';
    % For all the standard delimiters, choose the one that occurs most
    % frequently in the input data (or a subset thereof, if input data is
    % very large)
    testpoints=rand(length(data),1)<1000/length(data);
    testdata=[data{testpoints}];
    maxdelims=0;
    delimiter='	';
    for i=1:length(delims)
        if sum(testdata==delims(i))>maxdelims;
            delimiter=delims(i);
            maxdelims=sum(testdata==delims(i));
        end
    end
end


% Determine maximum number of columns in a row
columns=0; for i=1:length(data); columns=max(columns,sum(data{i}==delimiter)); end;
columns=columns+1;

% Determine upper limit on number of characters in a row
l=1; for i=1:length(data); l=max(l,length(data{i})); end; index=1:l;

% Import the data
dataout=cell(length(data),columns);
for i=1:length(data)
    delims=data{i}==delimiter;
    pos=[0 index(delims) length(data{i})+1];
    for j=1:(sum(delims)+1); dataout{i,j}=data{i}((pos(j)+1):(pos(j+1)-1)); end
end