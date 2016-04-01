% Write GERM partition coefficient database to c header file (to be
% accessed by calling getGERMKd("mineral","element",SiO2)

fp = fopen('GERM.h','w');

fprintf(fp,['double getGERMKd(const char mineral[], const char element[], const double SiO2){\n' ...
            '\tint index = (int) round(SiO2) - 40;\n'...
            '\tif (index < 0 ){\n'...
            '\t\tindex = 0;'...
            '\n\t} else if (index > 40 ){\n'...
            '\t\tindex = 40;\n'...
            '\t}\n'...
            '\t\n'...
            '\t']);
    

mins = p.minerals;
for i=1:length(mins);
    if i==1
        fprintf(fp,'\t');
    else
        fprintf(fp,' else ');
    end
    fprintf(fp,'if (strncasecmp(mineral,"%s",%i)==0){\n',mins{i},length(mins{i}));
    
    elems=p.(mins{i}).elements;
    
    e=1;
    for j=1:length(elems)
        t=isnan(p.(mins{i}).(elems{j}));
        if ~all(t) && isempty(strfind(elems{j},'_Err'))
            
            if any(t)
                p.(mins{i}).(elems{j})(t)=nanmean(p.(mins{i}).(elems{j}));
            end
            
            if e==1
                fprintf(fp,'\t\t');
            else
                fprintf(fp,' else ');
            end
            
            fprintf(fp,'if (strcasecmp(element,"%s")==0){\n',elems{j});
            
            fprintf(fp,'\t\t\tdouble kd[] = {');
            for k=1:41;
                fprintf(fp,'%E,',10.^p.(mins{i}).(elems{j})(k));
            end
            fprintf(fp,'};\n');
            fprintf(fp,'\t\t\treturn kd[index];\n');

            fprintf(fp,'\t\t}');
            e=e+1;
        end
    end
    
%     if e>1
%         fprintf(fp,' else {\n\t\t\treturn NAN;\n\t\t}');
%     else
%         fprintf(fp,'\t\treturn NAN;');
%     end
    
    fprintf(fp,'\n\t}');
end

fprintf(fp,['\n'...
            '\treturn NAN;\n'...
            '}\n']);

fclose(fp);


