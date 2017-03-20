function abundance = countUniques(inputArray)
% abundance = countUniques(textcell)
% Return a sorted list of all the unique entries in inputArray and their
% abundances

allparts = unique(inputArray(:));
nallparts=zeros(size(allparts));

% If input is a cell array
if iscell(allparts)
    for i=1:length(allparts)
        nallparts(i) = sum(strcmp(allparts{i},inputArray));
    end
    abundance = flipud(sortrows([allparts, num2cell(nallparts)],2));
    
% If input is a numeric array    
elseif isnumeric(allparts)
    for i=1:length(allparts)
        nallparts(i) = sum(allparts(i) == inputArray);
    end
    abundance = flipud(sortrows([allparts, nallparts],2));
else
    error('Requries numeric or text cell array input.\n');
end
