% Load p coefficients from GERM into a MATLAB struct

% Obtain the names of downloaded mineral files
filenames=dir('*.txt');

% Load the data into a struct
p.minerals=cell(length(filenames),1);
for i=1:length(filenames)
    name=varname(filenames(i).name(1:end-4));
    if ~isempty(name)
        data=import(filenames(i).name);
        % Delete any rows with only one entry (in GERM text files, these are unnecessary)
        data(sum(cellfun(@isempty,data),2)>size(data,2)-2,:)=[];
        % Store results
        p.(name).cell=data(2:end,:);
        p.(name).elements=data(1,:);
        p.minerals{i}=name;
    end
end

% Determine the unique reference / rock type pairs
samples=[];
for i=1:length(p.minerals)
    newsamples=[p.(p.minerals{i}).cell(:,10) p.(p.minerals{i}).cell(:,1)];
    samples=[samples; newsamples];
end
samples = sortrows(samples);
[samples{end+1,:}] = deal('');
j = ~all(strcmp(samples(1:end-1,:), samples(2:end,:)),2);
samples=samples(j,:);

% Determine the list of included elements
elements=[];
for i=1:length(p.minerals)
    elements=[elements; p.(p.minerals{i}).cell(:,4)];
end
elements=unique(elements);

tic;
% Sort the data into useful matrices
ei=1:length(elements);
si=1:length(samples);
eelements=[elements; cellfun(@(x) [x '_Err'],elements,'UniformOutput',false)];
for i=1:length(p.minerals)
    % Convert numeric entries of the cell array to a matrix
    vals=str2double(p.(p.minerals{i}).cell(:,5:8));
    % Convert standard deviation to log scale (?=log10(value+?)-log10(value))
    vals(:,2)=log10(vals(:,1)+abs(vals(:,2)))-log10(vals(:,1));
    % Convert p coefficients to log scale
    vals(:,[1,3,4])=log10(vals(:,[1,3,4]));
    % Combine the min-and-max with the value-and-std data
    vals(:,1)=nanmean([vals(:,1) nanmean(vals(:,3:4),2)],2);
    vals(:,2)=nanmean([vals(:,2) abs(vals(:,4)-vals(:,3))/4],2);
    %     % Use values from min and max, if available
    %     av=all(~isnan(vals(:,3:4)),2);
    %     vals(av,1)=mean(vals(av,4),vals(av,3));
    %     vals(av,2)=(vals(av,4)-vals(av,3))/4;
    
    % Isolate the useful text parts of the cell array
    id=p.(p.minerals{i}).cell(:,[10,1,4]);
    
    
    % Use cellfun to determine row and column indices of the p coeffs
    c=cellfun(@(a) ei(cellfun(@(x) isequal(x,a),elements)),id(:,3));
    r=cellfun(@(a,b) si(cellfun(@(x,y) isequal(x,a)&isequal(y,b),samples(:,1),samples(:,2))),id(:,1),id(:,2));
    
    % Allocate and fill data and error matrices for each sample
    data=NaN(length(samples),length(elements));
    err=NaN(length(samples),length(elements));
%     for j=1:size(vals,1)
%         data(r(j),c(j))=nanmean([data(r(j),c(j)) vals(j,1)]);
%         err(r(j),c(j))=nanmean([err(r(j),c(j)) vals(j,2)]);
%     end
    data((c-1).*size(data,1)+r)=vals(:,1);
    err((c-1).*size(err,1)+r)=vals(:,2);
    
    % Save results in the struct
    p.(p.minerals{i}).data=[data err];
    p.(p.minerals{i}).elements=eelements;
    p.(p.minerals{i})=elementify(p.(p.minerals{i}));
%     p.(p.minerals{i})=rmfield(p.(p.minerals{i}),'cell');
end
toc

str={'basalt','andesite','dacite','rhyolite','hawaiite','alkali basalt','basanite','benmoreite','camptonite','eclogite','garnet pyroxenite','kimberlite','komatiite','lampro','latite','leucitite','lherzolite','mugearite','panterllerite','trachyte','peridotite','phonolite','picrite','syenite','morb','tholeiite','tonalite','granodiorite','granite'};
val=[49,57.5,67.5,73,48.5,47,44,57,42,49,49,40,45,46.5,62.5,47,42,52,73,61,42,59,45.5,61,49,50,65,67.5,72];
err=[5,6.5,5.5,5,3.5,4,3,4,3,5,5,4,5,11.5,11.5,5,5,5,5,9,5,5,5.5,9,5,4,8,7.5,6];

p.samples=samples;
p.SiO2=NaN(length(p.samples),1);
p.SiO2_Err=NaN(length(p.samples),1);

for i=1:length(str)
    test=~cellfun('isempty', strfind(lower(samples(:,2)),str{i}));
    p.SiO2(test)=nanmean([p.SiO2(test) val(ones(sum(test),1),i)],2);
    p.SiO2_Err(test)=nanmean([p.SiO2_Err(test) err(ones(sum(test),1),i)],2);
end
