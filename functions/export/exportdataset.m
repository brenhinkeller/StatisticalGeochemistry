
function exportdataset(dataset,filename,delimiter)
fp = fopen(filename,'w');

if length(delimiter)==2 && all(delimiter == '\t')
    delimiter = '	';
end

dataset = unelementify(dataset);

for i=1:length(dataset.elements);
    fprintf(fp, '%s%s', dataset.elements{i},delimiter);
end
fseek(fp,-1,0);
fprintf(fp,'\n');


for i=1:size(dataset.data,1)
    for j=1:size(dataset.data,2)
        fprintf(fp, '%g%s', dataset.data(i,j), delimiter);
    end
    fseek(fp,-1,0);
    fprintf(fp, '\n');
end

fclose(fp);