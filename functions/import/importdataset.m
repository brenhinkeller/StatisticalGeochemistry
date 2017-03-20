function [data,varargout] = importdataset(filename, varargin)
% [data,[textdata]] = IMPORTDATASET(filename, delimiter, ['EarthChem'])
% Import a dataset as two structs, one for numeric data and one for text.
% If only one output argument requested, data and textdata are returned
% together

% Check input options
    earthchem = strcmpi('EarthChem',varargin);
    
% Import the full dataset as a cell array
    rawdata=importc(filename,varargin{~earthchem});

    % Remove any completely empty columns
    rawdata(:,all(cellfun(@isempty,rawdata),1))=[];
    % Remove any completely empty rows
    rawdata(all(cellfun(@isempty,rawdata),2),:)=[];

% Check for variable names
    if ~any(isempty(rawdata(1,:))) && sum(cellfun(@isplausiblyalphabetic,rawdata(1,:))) > sum(cellfun(@isplausiblynumeric,rawdata(1,:)))
        % If first row is mostly non-numeric, treat it as column titles
        elements=rawdata(1,:)';
        % Convert strings to acceptible variable names
        elements=fieldname(elements);
        if any(earthchem)
            elements=capitalizeElements(elements);
        end
    else
        error('Error: missing column names')
    end
    
% Find the numeric columns
    NumericColumns=false(size(rawdata(1,:)));
    % Normal options
    if ~any(earthchem)
        for i=1:length(elements)
            if sum(cellfun(@isplausiblynumeric,rawdata(2:end,i))) > sum(cellfun(@isplausiblyalphabetic,rawdata(2:end,i)))
                % If the column is more plausibly numeric than not, treat
                % it as such (if a tie, text wins)
                NumericColumns(i)=true;
            end
        end
    
% Special exceptions for EarthChem data
    else
        for i=1:length(elements)
            if sum(cellfun(@isplausiblynumeric,rawdata(2:end,i))) >= sum(cellfun(@isplausiblyalphabetic,rawdata(2:end,i)))
                % If the column is equally or more plausibly numeric than
                % not, treat it as numeric (if a tie, numeric wins) 
                NumericColumns(i)=true;
            end
        end
        % If the variable name includes 'Sample_ID', etc., treat it as text
        NumericColumns(strcmp(elements,'Sample_ID'))=false;
        NumericColumns(strcmp(elements,'Cruise_ID'))=false;
        NumericColumns(strcmp(elements,'Igsn'))=false;
        NumericColumns(strcmp(elements,'Mineral'))=false;
        % Treat all column names containing '_Unit' or '_Method' as text
        NumericColumns(~cellfun(@isempty, strfind(elements,'_Unit')))=false;
        NumericColumns(~cellfun(@isempty, strfind(elements,'_Meth')))=false;
    end  

    
% Remove non-numeric characters from numeric columns
    for i=1:length(elements)
        if NumericColumns(i)
            % Remove any characters that aren't digits, a decimal point, or exponential notation
            rawdata(2:end,i)=regexprep(rawdata(2:end,i),'[^-0-9.eE]',''); 
        end
    end
    
% Treat everything else as a text column
    TextColumns=~NumericColumns;
    
% Output numeric data (if any) as struct
    if sum(NumericColumns)>0
        data=struct;
        data.elements=elements(NumericColumns); % Cell array variable names
        % Convert cell array of strings to numbers
        data.data=str2double(rawdata(2:end,NumericColumns));
        % Distribute each column to its own variable
        data=elementify(data);
    else
        data=[];
    end
    
% Output text data (if any) as struct
    if sum(TextColumns)>0
        textdata=struct;
        textdata.elements=elements(TextColumns); % Cell array of variable names
        textdata.data=rawdata(2:end,TextColumns); % Cell array of text
        % Distribute each column to its own variable
        textdata=elementify(textdata);
    else
        textdata=[];
    end

% If only one output argument is requested, combine text and numeric data
% into one struct
    if nargout>1
        varargout{1} = textdata;
    else
        data = mergedatasets(textdata,data);
    end
    
    



