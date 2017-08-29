function [fileFullList, fileNameList] = get_EPRspectra_Files(dirName)
%% Поиск списка файлов с заданными расширениями
% Поиск файлов с расширением *.DSC
[fileFullList_dsc, fileNameList_dsc] = get_DSC_Files(dirName);
% Поиск файлов с расширением *.par
[fileFullList_par, fileNameList_par] = get_PAR_Files(dirName);
fileFullList= vertcat(fileFullList_dsc,fileFullList_par);
fileNameList= vertcat(fileNameList_dsc,fileNameList_par);
% % Поиск файлов с расширением *.DSC
%     dirName = [dirName, filesep];
%   dirData = dir(dirName);      %# Get the data for the current directory
%   dirIndex = [dirData.isdir];  %# Find the index for directories
%   dirIndex = ~dirIndex;
%   dirList = {dirData(dirIndex).name}';  %'# Get a list of the files
%   
%   msk{1} = char('.DSC');
%   msk{2} = char('.par');
%   l = length(msk);
%   logArr = zeros(length(dirList),l);
%     % Просматриваем каталог на наличие записанных файлов с заданной маской
%     for i = 1:l
%         fnd{i} = strfind(dirList, msk{i});
%         % Ищем пустые элементы в cell
%         logArr(:,i) = cellfun(@(x) ~isempty(x),fnd{i});
%     end
%     
%     Bchr = logArr(:,1);
%     for i = 2:l
%         Bchr = Bchr|logArr(:,i);
%     end
% %     Bchr = strfind(dirList, msk);
%     
%     % Ищем пустые элементы в cell
% %     Loc = cellfun(@(x) isempty(x),Bchr);
%     Loc = ~Bchr;
%     % Убираем их из cell
%     dirList(Loc)=[];
%   
%   if ~isempty(dirList)
%     
%     fileFullList = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
%                        dirList,'UniformOutput',false);
%   end
%   fileNameList = dirList;
%   if isempty(fileNameList)
%       fileFullList = fileNameList;
%   end
%                                                
% %   for iDir = find(validIndex)                  %# Loop over valid subdirectories
% %     nextDir = fullfile(dirName,subDirs{iDir});    %# Get the subdirectory path
% %     fileList = [fileList; getAllFiles(nextDir)];  %# Recursively call getAllFiles
% %   end
%     
% 
% % параллельно делаем цикл на поиск файлов с расширением
end