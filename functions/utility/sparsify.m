function strct = sparsify(strct,varargin)
% strct = sparsifyTextDataset(strct,['removeunits'])
% Compress sparse datasets into unique components
% See also densify

% Sparsification for units and methods
if nargin==2 && strcmpi('removeunits',varargin{1})
    
    % Sparsify units
    if ~isfield(strct,'Units')
        % Create list of all unique units
        Units={''};
        elems = strct.elements(~cellfun(@isempty, strfind(strct.elements,'Unit')));
        for i=1:length(elems)
            if sum(~cellfun(@isempty,strct.(elems{i})))>0
                Units = unique(upper([Units; strct.(elems{i})(~cellfun(@isempty, strct.(elems{i})))]));
            end
        end
        strct.Units = Units;
        % Replace cell arrays with sparse indexes
        for i=1:length(elems)
            % Create new sparse index
            strct.unit.(elems{i}) = sparse(length(strct.(elems{i})),1);
            for j = 2:length(strct.Units)
                strct.unit.(elems{i})(strcmpi(strct.Units{j},strct.(elems{i}))) = j-1;
            end
            % Delete original variable
            strct = rmfield(strct,elems{i});
        end
        strct.elements = setxor(strct.elements, elems); % Remove deleted variables from elements list
    else
        warning('Units appear already sparse.\n');
    end
    
    % Sparsify methods
    if ~isfield(strct,'Methods')
        % Create list of all unique methods
        Methods={''};
        elems = strct.elements(~cellfun(@isempty, strfind(strct.elements,'Meth')));
        for i=1:length(elems)
            if sum(~cellfun(@isempty,strct.(elems{i})))>0
                Methods = unique([Methods; strct.(elems{i})(~cellfun(@isempty, strct.(elems{i})))]);
            end
        end
        strct.Methods = Methods;
        % Replace cell arrays with sparse indexes
        for i=1:length(elems)
            % Create new sparse index
            strct.method.(elems{i}) = sparse(length(strct.(elems{i})),1);
            for j = 2:length(strct.Methods)
                strct.method.(elems{i})(strcmpi(strct.Methods{j},strct.(elems{i}))) = j-1;
            end
            % Delete original variables
            strct = rmfield(strct,elems{i});
        end
        strct.elements = setxor(strct.elements, elems); % Remove deleted variables from elements list
    else
        warning('Methods appear already sparse.\n');
    end
    
end



% Normal sparsification
sparsetext = false;
if isfield(strct,'index')
    warning('Dataset appears to be already sparse\n');
    sparsetext = true;
end

elems = strct.elements;
for i=1:length(elems)
    clmn = strct.(elems{i});
    
    % If we're looking at a cell array
    if iscell(clmn) && ~sparsetext
        % find any empty cells
        emptycells = cellfun(@isempty, clmn);
        
        clmn(emptycells) = {''}; % Fill empty cells with empty string
        [uniqs,~,ic] = unique(clmn); % Find unique elements
        % If empty strings are present, decrement the index by one
        % Else add an empty string to the uniques
        if sum(strcmpi('',uniqs))>0
            ic = ic-1;
        else
            uniqs = unique([{''};uniqs]);
        end
        % Sparsify if helpful
        if sum(ic==0)>length(ic)/2
            ic = sparse(ic);
        end
        strct.(elems{i}) = uniqs;
        strct.index.(elems{i}) = ic;
        
%     % Otherwise if we're looking at a numeric variable
%     elseif isnumeric(clmn) && ~issparse(clmn) && sum(isnan(clmn))>length(clmn)/2
%         clmn(isnan(clmn)) = 0;
%         strct.(elems{i}) = sparse(clmn);
    end
end




