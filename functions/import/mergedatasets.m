function out=mergedatasets(in1,in2)
% Combine fields from two struct-based datasets with equal-length variables

% Figure out if we have the right input
if ~isstruct(in1) || ~isstruct(in2)
    % If one input is empty, nothing to do.
    if isstruct(in1) && isempty(in2)
        out = in1;
    elseif isstruct(in2) && isempty(in1)
        out = in2;
    else
        % If the input data is not a struct, return error
        error('Error: requires struct input.')
    end
else
    % Do the merge
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
    
    if in1length~=in2length
        error('Error: variables must be equal length')
    end
    
    out = in1;
    out.elements=unique([in1.elements; in2.elements]);
    
    for e = in2.elements'
        % Fill in fields from in2
        out.(e{1})=in2.(e{1});
    end
end