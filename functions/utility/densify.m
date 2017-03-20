function strct = densify(strct)
% strct = densifyTextDataset(strct)
% Expand text or numeric dataset into full dense arrays 
% See also sparsify

sparsetext = true;
if ~isfield(strct,'index')
    warning('Dataset does not appear to be sparse')
    sparsetext = false;
end

elems = strct.elements;
for i=1:length(elems)
    % If column is a cell array
    if iscell(strct.(elems{i})) && sparsetext
        uniqs = strct.(elems{i});
        strct.(elems{i}) = uniqs(strct.index.(elems{i}) + 1);
    
%     % Otherwise if column is numeric
%     elseif isnumeric(strct.(elems{i})) && issparse(strct.(elems{i}))
%         strct.(elems{i}) = full(strct.(elems{i}));
%         strct.(elems{i})(strct.(elems{i})==0)=NaN;
    end
end

if sparsetext
    strct = rmfield(strct,'index');
end


