function A = mDisplayEPRfiles_loadFiles_v_01 
% Загружаем файлы для обработки в тестовом режиме
        start_path = '/home/yugin/VirtualboxShare/Prohorov/data';
        folder_name = uigetdir(start_path);

    if folder_name == 0
        disp('Cancel');
        return;
    end
    B.defPath = folder_name;
    chr_folder_name = char(folder_name);
    tok = regexp(folder_name,'/(\w+)', 'tokens'); 
    % Генерируем новое имя для папки
    out_dir = [char(tok{end}), '_', 'ready'];
    chr = strfind(folder_name, '/');
    start_dir_name = chr_folder_name(1:chr(end));
    out_dir = [start_dir_name ,out_dir ];
    B.dirName = out_dir;
    % Создаем общую папку
    %=========================================>>
    % Создаем папку если она еще не была создана
    if exist (out_dir,'dir') ==0
       mkdir(out_dir);
    end;


    % Получаем список всех файлов в подкатологах
    B.fileList = getAllFiles(folder_name);

    % Вводим маску поиска
    prompt = {'Enter mask of file name:'};
    dlg_title = 'Input for mask';
    num_lines = 1;
    def = {'.DSC'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    fln_mask = answer{1};
    % Просматриваем каталог на наличие записанных файлов с заданной маской
    B.chr = strfind(B.fileList, fln_mask);
    % Ищем пустые элементы в cell
    Loc = cellfun(@(x) isempty(x),B.chr);
    % Убираем их из cell
    B.fileList(Loc)=[];


    k = 1;
    ks = 1;
    [pathstr, B.name, ext] = cellfun(@fileparts, B.fileList,'UniformOutput', false );
    if length(B.fileList) > 0
        % если файл уже существует, то загружаем его
        [B.sFiles,v] = listdlg('PromptString','Select a saved *.dat file:',...
                    'SelectionMode','multiple',...
                    'ListString',B.name, 'ListSize', [600,220]);
                drawnow; pause(0.05);
        if v == 0 
            A = B;
            return;
        else
            A = B;
        end
    end