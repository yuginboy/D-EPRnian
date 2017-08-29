function [fileFullList, fileNameList] = getFiles(dirName)
% Рекурсивный поиск файлов в подкаталогах

  dirData = dir(dirName);      %# Get the data for the current directory
  dirIndex = [dirData.isdir];  %# Find the index for directories
  dirIndex = ~dirIndex;
  dirList = {dirData(dirIndex).name}';  %'# Get a list of the files
  subDirs = {dirData(dirIndex).name};  %# Get a list of the subdirectories
  
  if ~isempty(dirList)
    
    fileFullList = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
                       dirList,'UniformOutput',false);
  end
  fileNameList = dirList;
                                               
%   for iDir = find(validIndex)                  %# Loop over valid subdirectories
%     nextDir = fullfile(dirName,subDirs{iDir});    %# Get the subdirectory path
%     fileList = [fileList; getAllFiles(nextDir)];  %# Recursively call getAllFiles
%   end

end