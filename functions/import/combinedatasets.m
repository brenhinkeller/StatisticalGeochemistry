function out=combinedatasets(in1,in2)
% Combine two struct-based datasets with equal-length variables

% If the input data is not a struct, return error
if ~isstruct(in1) || ~isstruct(in2)
    error('Error: requires struct input.')
end

% If 'elements' field doesn't exist, populate it
if ~isfield(in1,'elements')
    in1.elements=fieldnames(in1);
end
if ~isfield(in2,'elements')
    in1.elements=fieldnames(in2);
end

% Find variable length, assuming it's the same for both structs
in1length=length(in1.(in1.elements{1}));
in2length=length(in2.(in2.elements{1}));

out.elements=unique([in1.elements; in2.elements]);
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
