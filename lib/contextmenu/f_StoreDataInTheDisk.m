function f_StoreDataInTheDisk (B)
% Функция записи информации о регионах для обработанных кривых на диск
% Причем запись производится в файл с расширением .depr 
% Для записанной структуры данных необходимо сохранение иерархии папок и
% файлов, которые были в момент записи файла
B = getappdata(B.hFig,'B');

[B.filenameToStore, B.pathnameToStore] = uiputfile(...
 {'*.depr';'*.*'},...
 'Save as',...
 [B.defPath, filesep, 'project.depr']);
if B.pathnameToStore == 0
    return
end
fullFileNameToStore = [fullfile(B.pathnameToStore,B.filenameToStore)];
save(fullFileNameToStore, 'B','-mat');
disp(['Store data to the: ', fullFileNameToStore]);
setappdata(B.hFig,'B',B);
end