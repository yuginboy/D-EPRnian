function mDisplayEPRfiles_loadDir_v_01 (B)
% Выбор папки для работы
B = getappdata(B.hFig,'B');
        start_path = B.defPath;
%         start_path = pwd;
        folder_name = uigetdir(start_path);

    if folder_name == 0
        disp('Cancel');
%         return;
    end
    B.defPath = folder_name;
%     chr_folder_name = char(folder_name);
%     tok = regexp(folder_name,'/(\w+)', 'tokens'); 
%     % Генерируем новое имя для папки
%     out_dir = [char(tok{end}), '_', 'ready'];
%     chr = strfind(folder_name, '/');
%     start_dir_name = chr_folder_name(1:chr(end));
%     out_dir = [start_dir_name ,out_dir ];
%     B.dirName = out_dir;
%     % Создаем общую папку
%     %=========================================>>
%     % Создаем папку если она еще не была создана
%     if exist (out_dir,'dir') ==0
%        mkdir(out_dir);
%     end;

    setappdata(B.hFig,'B',B);
end
