function strct = unelementify(strct, varargin)
% strct = UNELEMENTIFY(strct, ['keep'])
% Separates an M by N matrix strct.data into N column vectors according to 
% the N names in cell array strct.elements. If 'keep' flag is selected, the
% preexisting variables will be retained

% If the input data is not a struct, return error
    if ~isstruct(strct)
        error('requires struct input.')
    end
    
% Deterimine if individual fields should be kept
    if nargin==2
        if all(varargin{1}=='keep') || all(varargin{1}=='k')
            keep=1;
        end
    else
        keep=0;
    end
    
    
    
% If field '.elements' exists, combine each named variable into an array
    if isfield(strct,'elements') 
        
  % If all variables are numeric, we can use a numeric array
        if all(cellfun(@(x) isa(strct.(x),'numeric'), strct.elements))
            % Create .data matrix
            strct.data=NaN(length(strct.(strct.elements{1})),length(strct.elements));
            for i=1:length(strct.elements)
                if isfield(strct,strct.elements{i})
                    % Fill .data matrix with the variables listed in .elements
                    strct.data(:,i)=strct.(strct.elements{i});
                    
                    % Remove unneeded fields if 'keep' option was not specified
                    if ~keep
                        strct=rmfield(strct, strct.elements{i});
                    end
                    
                % Print warning if any fields are missing
                else
                    warning('Missing field "%s"',strct.elements{i})
                end
                
            end
            
  % If any variables are not numeric, we must use a cell array
        elseif any(cellfun(@(x) isa(strct.(x),'cell'), strct.elements))
            % Create .data cell array
            strct.data=cell(length(strct.(strct.elements{1})),length(strct.elements));
            for i=1:length(strct.elements)
                if isfield(strct,strct.elements{i})
                    % Fill .data matrix with the variables listed strct .elements
                    if isnumeric(strct.(strct.elements{i}))
                        strct.data(:,i)=num2cell(strct.(strct.elements{i}));
                    else
                        strct.data(:,i)=strct.(strct.elements{i});
                    end
                    
                    % Remove unneeded fields if 'keep' option was not specified
                    if ~keep
                        strct=rmfield(strct, strct.elements{i});
                    end
                    
                % Print warning if any fields are missing
                else
                    warning('Missing field "%s"',strct.elements{i})
                end
            end
            
  % If variables are not numeric or cell, return error
        else
            error('Invalid data type')
        end
        
% Complain and quit if we don't have a '.elements' field
    else
        error('Input is missing ''.elements'' field')
    end
end

