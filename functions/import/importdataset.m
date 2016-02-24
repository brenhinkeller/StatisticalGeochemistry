function [data,textdata] = importdataset(filename, varargin)
% Import a dataset as two structs, one for numeric data and one for text

rawdata=importc(filename,varargin{:});

if ~any(isempty(rawdata(1,:))) && sum(cellfun(@isplausiblyalphabetic,rawdata(1,:))) > sum(cellfun(@isplausiblynumeric,rawdata(1,:)))
    % If first row is mostly non-numeric, treat it as column titles
    elements=rawdata(1,:)';
    % Convert strings to acceptible variable names
    elements=varname(elements);
else
    error('Error: missing column names')
end

% Find the numeric columns
NumericColumns=false(size(rawdata(1,:)));
for i=1:length(elements)
    if sum(cellfun(@isplausiblynumeric,rawdata(2:end,i))) > sum(cellfun(@isplausiblyalphabetic,rawdata(2:end,i)))
        % If the column is more plausibly numeric than not, treat it as such
        NumericColumns(i)=true;
        rawdata(2:end,i)=cellfun(@addnanstring,rawdata(2:end,i),'UniformOutput',false); %NaN out cells that don't contain digits
        rawdata(2:end,i)=regexprep(rawdata(2:end,i),'[^0-9.(NaN)]',''); % Remove any characters that aren't digits, a decimal point, or a NaN
    end
end
% If the variable name includes 'Sample_ID', treat it as text
NumericColumns(~cellfun(@isempty, strfind(elements,'Sample_ID')))=false;

% Treat everything else as a text column
TextColumns=~NumericColumns;

% Output numeric data
if sum(NumericColumns)>0
    data=struct;
    data.elements=elements(NumericColumns);
    data.data=cellfun(@str2num, rawdata(2:end,NumericColumns));
    data=elementify(data);
else
    data=[];
end

% Output text data
if sum(TextColumns)>0
    textdata=struct;
    textdata.elements=elements(TextColumns);
    textdata.data=rawdata(2:end,TextColumns);
    textdata=elementify(textdata);
else
    textdata=[];
end



