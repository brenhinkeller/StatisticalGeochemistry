function out=concatenatedatasets(in1,in2)
% Append two struct-based datasets variable-by-variable

% If the input data is not a struct, return error
if ~isstruct(in1) || ~isstruct(in2)
    error('Error: requires struct input.')
end

if isempty(fieldnames(in1))
    out = in2;
elseif isempty(fieldnames(in2))
    out = in1;
else
    % If 'elements' field doesn't exist, populate it
    if ~isfield(in1,'elements')
        in1.elements=fieldnames(in1);
    end
    if ~isfield(in2,'elements')
        in1.elements=fieldnames(in2);
    end
    
    % Find variable length
    in1length=length(in1.(in1.elements{1}));
    in2length=length(in2.(in2.elements{1}));
    
    % out.elements=unique([in1.elements; in2.elements]);
    out.elements=union(in1.elements,in2.elements,'stable');
    for e = out.elements'
        % Make any missing fields
        if isfield(in1, e{1}) && ~isfield(in2, e{1}) && isa(in1.(e{1}),'numeric')
            in2.(e{1})=NaN(in2length,1);
        elseif isfield(in1, e{1}) && ~isfield(in2, e{1}) && isa(in1.(e{1}),'cell')
            in2.(e{1})=cell(in2length,1);
        elseif isfield(in2, e{1}) && ~isfield(in1, e{1}) && isa(in2.(e{1}),'numeric')
            in1.(e{1})=NaN(in1length,1);
        elseif isfield(in2, e{1}) && ~isfield(in1, e{1}) && isa(in2.(e{1}),'cell')
            in1.(e{1})=cell(in1length,1);
        end
        
        % Combine fields
        out.(e{1})=[in1.(e{1}); in2.(e{1})];
    end
end