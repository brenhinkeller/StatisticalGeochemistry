
function exportmatrix(data,filename,delimiter)
fp = fopen(filename,'w');

if length(delimiter)==2 && all(delimiter == '\t')
    delimiter = '	';
end

for i=1:size(data,1)
    for j=1:size(data,2)
        fprintf(fp, '%g%s', data(i,j), delimiter);
    end
    fseek(fp,-1,0);
    fprintf(fp, '\n');
end

fclose(fp);