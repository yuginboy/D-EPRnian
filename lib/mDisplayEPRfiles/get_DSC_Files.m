function [fileFullList, fileNameList] = get_DSC_Files(dirName)
% Поиск файлов с расширением *.DSC
    dirName = [dirName, filesep];
  dirData = dir(dirName);      %# Get the data for the current directory
  dirIndex = [dirData.isdir];  %# Find the index for directories
  dirIndex = ~dirIndex;
  dirList = {dirData(dirIndex).name}';  %'# Get a list of the files
  
  msk = char('.DSC');
    % Просматриваем каталог на наличие записанных файлов с заданной маской
    Bchr = strfind(dirList, msk);
    % Ищем пустые элементы в cell
    Loc = cellfun(@(x) isempty(x),Bchr);
    % Убираем их из cell
    dirList(Loc)=[];
  
  if ~isempty(dirList)
    
    fileFullList = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
                       dirList,'UniformOutput',false);
  end
  fileNameList = dirList;
  if isempty(fileNameList)
      fileFullList = fileNameList;
  end
                                               
%   for iDir = find(validIndex)                  %# Loop over valid subdirectories
%     nextDir = fullfile(dirName,subDirs{iDir});    %# Get the subdirectory path
%     fileList = [fileList; getAllFiles(nextDir)];  %# Recursively call getAllFiles
%   end

end