function [out]=importfolder(varargin)
% [out]=importfolder(filter,extension length,path)
% Import all the files in a folder containing pattern 'filter' in their
% filenames into a struct. If extension length is specified, extension will
% be subtracted from the file name.
if nargin>3; error('Too many input arguments'); end
if nargin>2; folderpath=varargin{3}; cd(folderpath); end
if nargin>1; extlen=varargin{2}; else extlen=0; end
if nargin>0;
    filenames=dir(varargin{1});
else
    filenames=dir;
    %     filenames(cell2mat(arrayfun(@(x) all(x.name=='.'), filenames,'UniformOutput',false)))=[];
    %     filenames(cell2mat(arrayfun(@(x) isequal(x.name,'.DS_Store'), filenames,'UniformOutput',false)))=[];
end

if size(filenames,1)==0; error('No matching files. Consider using more wildcards (*) in filter'); end

out.names=cell(length(filenames),1);
for i=1:length(filenames)
    name=varname(filenames(i).name(1:end-extlen));
    if ~isempty(name)
        out.(name).data=importc(filenames(i).name);
        out.names{i}=name;
    end
end

