function strct = elementify(strct, varargin)
% strct = ELEMENTIFY(strct, ['keep'])
% Separates an M by N matrix strct.data into N column vectors according to
% the N names in cell array strct.elements. If 'keep' flag is selected, the
% preexisting '.data' field will be retained

% If the input data is not a struct, return error
    if ~isstruct(strct)
        error('Requires struct input.')
    end
    
% Deterimine if previous data field should be retained
    if nargin==2
        if all(varargin{1}=='keep') || all(varargin{1}=='k')
            keep=1;
        end
    else
        keep=0;
    end
    
% If strct.data field exists, distribute each column into its own variable
    if isfield(strct,'data') && isfield(strct,'elements')
        % Create all the variables corresponding to the names in strct.elements
        for i=1:length(strct.elements)
            if iscell(strct.data) && all(cellfun(@isnumeric, strct.data(:,i)))
                strct.(strct.elements{i})=cell2mat(strct.data(:,i));
            else
                strct.(strct.elements{i})=strct.data(:,i);
            end
        end
        
        % Remove unneeded data matrix s
        if ~keep
            strct=rmfield(strct, 'data');
        end

% Otherwise, return error
    else
        error('Input is missing either ''.data'' or ''.elements'' field')
    end
end

