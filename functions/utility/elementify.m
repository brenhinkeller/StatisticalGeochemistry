function out = elementify(in, varargin)
% Separates an m by n matrix in.data into n column vectors according to the
% n names in cell array in.elements.

% If the input data is not a struct, return error
if ~isstruct(in)
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

% If data exists  
if isfield(in,'data') && isfield(in,'elements')
    % Create all the variables corresponding to the names in in.elements
    for i=1:length(in.elements)
        if iscell(in.data) && all(cellfun(@isnumeric, in.data(:,i)))
            in.(in.elements{i})=cell2mat(in.data(:,i));
        else
            in.(in.elements{i})=in.data(:,i);
        end
    end
    
    % Remove unneeded data matrix
    if ~keep
        in=rmfield(in, 'data');
    end
    
    % Save the results
%     if exist('name','var')
%         eval([name '=in;'])
%         eval(['save ' name '.mat ' name])
%     else
%         out=in;
%     end
    out=in;
else
    error('input does not contain .data or .elements field')
end
    


end

