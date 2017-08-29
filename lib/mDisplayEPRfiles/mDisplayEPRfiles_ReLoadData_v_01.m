function mDisplayEPRfiles_ReLoadData_v_01(B)
% Перезагружаем данные. Данная функция очень похожа на аналогичную по
% названию mDisplayEPRfiles_loadData_v_01(B) но здесь в трех местах
% заменены в if знаки неравенства на знаки тождества. Это позволяет
% перезагрузить данные использую функцию mload_EPR_data (filename,B) с
% перечитанными параметрами для отображения или нет сглаживания и пересчет
% количества точек для сглаживания. Т.е. как только изменяется значение в
% поле B.eb_NumberAutoSmoothForLoadSpectra и нажимается Enter все спектры в
% рабочей области программы пересчитываются с новыми значениями для количества 
% точек сглаживания.
% Также отключил автоматическое переключение на автомасштабирование
B = getappdata(B.hFig,'B');

B.indexDir = get(B.lb_dir, 'Value');
B.indexFiles = get(B.lb_files, 'Value');
B.indexStruct = get(B.lb_struct, 'Value');
B.freezeScale = get(B.hb_fixScale, 'Value');

% Если изменения произошли в списке Dir -- Здесь приравниваю, чтобы
% загрузились и обработались по новому все спектры из списка Dir

% Если выбрал .. то изменяем каталог на верхний
if strcmp (B.dirNameList{B.indexDir},'..')
%     disp(B.defPath);
    [B.defPath] = fileparts(B.defPath);
%     disp(B.defPath);
end

if B.indexDir == B.indexDirOld
    % меняем статус, название и фон у кнопки hb_fixScale делаем
    % автомасштаб
%     set(B.hb_fixScale, 'Value',0);
%     set(B.hb_fixScale, 'BackgroundColor', [0.701961 0.701961 0.701961]);
%     set(B.hb_fixScale, 'String', 'Auto scale');
%     B.freezeScale = get(B.hb_fixScale, 'Value');
    if ~strcmp (B.dirNameList{B.indexDir},'.') 
        if ~strcmp (B.dirNameList{B.indexDir},'.')
            B.defPath = B.dirFullList{B.indexDir};
            [B.dirFullList, B.dirNameList] = getDirs(B.defPath);
            [B.fileFullList, B.fileNameList] = get_EPRspectra_Files(B.defPath);
            B.indexDir = 1;
            set(B.lb_dir, 'Value',1);
            set(B.lb_files, 'Value', 1);
            set(B.lb_struct, 'Value', 1);

            B.indexFiles = get(B.lb_files, 'Value');
            B.indexStruct = get(B.lb_struct, 'Value');

            set(B.lb_dir, 'string', B.dirNameList);   
            set(B.lb_files, 'string', B.fileNameList, 'min', 0, 'max', length(B.fileNameList));
            if ~isempty(B.fileFullList)
                setappdata(B.hFig,'B',B);
                [B.X,B.Y,B.alpha,B.info,B.src_Y]=mload_EPR_data(B.fileFullList{1},B);
                freq = regexp(B.info.FrequencyMon, '[-+]?[0-9]*\.?[0-9]+', 'match');
                B.freq = str2num(freq{1});
                B.y = B.Y(:,1);
                B.x = B.X;
                B.src_y = B.src_Y(:,1);
                set(B.ht_filename, 'string', B.fileNameList{1});
            else
                B.x = [0, 1];
                B.y = [0, 1];
                B.X = [0, 1]';
                B.Y = [0, 1]';
                B.src_y = [0, 1];
                B.alpha = '--';
                B.info = '--';
                set(B.ht_filename, 'string', 'filename');
            end
            set(B.lb_struct, 'string', B.alpha,'min', 0, 'max', length(B.alpha));

%             set(B.lb_text, 'style', 'text');
%             B.infoTXT = evalc('disp(B.info)');
%             set(B.lb_text, 'string', B.infoTXT);
%             set(B.lb_text, 'style', 'listbox');

            
            B.indexDirOld = B.indexDir;
            if B.freezeScale ~= 1
                setappdata(B.hFig,'B',B);
                mDisplayEPRfiles_autoScale_v_01(B);
                B = getappdata(B.hFig,'B');
            end
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_pltData_v_02 (B);
            B = getappdata(B.hFig,'B');
            
            % Замораживаем масштаб:
            set(B.hb_fixScale, 'Value',1);
            set(B.hb_fixScale, 'BackgroundColor', [0.1 0.701961 0.701961]);
            set(B.hb_fixScale, 'String', 'Hold scale');
            B.freezeScale = get(B.hb_fixScale, 'Value');
        end
    end
end

B.indexFilesShadowView = B.indexFiles(end);
% Если изменения произошли в списке Files -- Здесь приравниваю, чтобы
% загрузились и обработались по новому все спектры из списка Files
if B.indexFilesShadowView == B.indexFilesOld
%     % меняем статус, название и фон у кнопки hb_fixScale делаем
%     % автомасштаб
%     set(B.hb_fixScale, 'Value',0);
%     set(B.hb_fixScale, 'BackgroundColor', [0.701961 0.701961 0.701961]);
%     set(B.hb_fixScale, 'String', 'Auto scale');
%     B.freezeScale = get(B.hb_fixScale, 'Value');
% % меняем статус, название и фон у кнопки hb_fixScale делаем
% % автомасштаб
%     set(B.hb_fixScale, 'Value',0);
%     set(B.hb_fixScale, 'BackgroundColor', [0.701961 0.701961 0.701961]);
%     set(B.hb_fixScale, 'String', 'Auto scale');
%     B.freezeScale = get(B.hb_fixScale, 'Value');

    if ~isempty(B.fileNameList)
        setappdata(B.hFig,'B',B);
        [B.X,B.Y,B.alpha,B.info,B.src_Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView}, B);
        freq = regexp(B.info.FrequencyMon, '[-+]?[0-9]*\.?[0-9]+', 'match');
        B.freq = str2num(freq{1});
        B.y = B.Y(:,1);
        B.x = B.X;
        B.src_y = B.src_Y(:,1);
        set(B.ht_filename, 'string', B.fileNameList{B.indexFilesShadowView});
    else
        B.x = [0, 1];
        B.y = [0, 1];
        B.X = [0, 1]';
        B.Y = [0, 1]';
        B.src_y = [0, 1];
        B.alpha = '--';
        B.info = '--';
        set(B.ht_filename, 'string', 'filename');
    end
%    if strcmp( B.fileNameList{B.indexFiles},'130.DSC')
%        disp ('130')
%    end
%     set(B.lb_text, 'style', 'text');
%     B.infoTXT = evalc('disp(B.info)');
%     set(B.lb_text, 'string', B.infoTXT);
%     set(B.lb_text, 'style', 'listbox');

   B.indexFilesOld = B.indexFilesShadowView;
   set(B.lb_struct, 'string', B.alpha,'min', 0, 'max', length(B.alpha));
   setappdata(B.hFig,'B',B);
   B = getappdata(B.hFig,'B');

   if B.freezeScale ~= 1 
       setappdata(B.hFig,'B',B);
       mDisplayEPRfiles_autoScale_v_01(B);
       B = getappdata(B.hFig,'B');
   end
    setappdata(B.hFig,'B',B);
    mDisplayEPRfiles_pltData_v_02 (B);
    B = getappdata(B.hFig,'B');

%     % Замораживаем масштаб:
%     set(B.hb_fixScale, 'Value',1);
%     set(B.hb_fixScale, 'BackgroundColor', [0.1 0.701961 0.701961]);
%     set(B.hb_fixScale, 'String', 'Hold scale');
%     B.freezeScale = get(B.hb_fixScale, 'Value');
end


B.indexStructShadowView = B.indexStruct(end);
% Если изменения произошли в списке Struct -- Здесь приравниваю, чтобы
% загрузились и обработались по новому все спектры из списка Struct
    if B.indexStructShadowView == B.indexStructOld

        B.y = B.Y(:,B.indexStructShadowView);
        B.src_y = B.src_Y(:,B.indexStructShadowView);
        B.indexStructOld = B.indexStructShadowView;


        if B.freezeScale ~= 1
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_autoScale_v_01(B);
            B = getappdata(B.hFig,'B');
        end
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_pltData_v_02 (B);
        B = getappdata(B.hFig,'B');

    end

% Определяем переменные для графиков тени до и после текущего графика
% спектра:
for i = 1:3
    B.x_before{i} = B.x;
    B.y_before{i} = B.y;
    B.x_after{i} = B.x;
    B.y_after{i} = B.y;
end
% Проверяем количество файлов в папке:
lm = length(B.fileFullList);

    % Проверяем, является ли файл структурой с угловой разверткой:
    [n,m] = size(B.Y);
    B.indexStructShadowView = B.indexStruct(end);
if m > 1   
    % для линий тени на несколько шагов после текущего спектра ЭПР
    if (m - B.indexStructShadowView) == 1
        B.x_after{1} = B.x;
        B.y_after{1} = B.Y(:,B.indexStructShadowView + 1);
    elseif (m - B.indexStructShadowView) == 2
        B.x_after{1} = B.x;
        B.y_after{1} = B.Y(:,B.indexStructShadowView + 1);
        B.x_after{2} = B.x;
        B.y_after{2} = B.Y(:,B.indexStructShadowView + 2);
    elseif (m - B.indexStructShadowView) > 2
        B.x_after{1} = B.x;
        B.y_after{1} = B.Y(:,B.indexStructShadowView + 1);
        B.x_after{2} = B.x;
        B.y_after{2} = B.Y(:,B.indexStructShadowView + 2);
        B.x_after{3} = B.x;
        B.y_after{3} = B.Y(:,B.indexStructShadowView + 3);
    end

    % для линий тени на несколько шагов ДО текущего спектра ЭПР
    if (B.indexStructShadowView) == 2
        B.x_before{1} = B.x;
        B.y_before{1} = B.Y(:,B.indexStructShadowView - 1);
    elseif (B.indexStructShadowView) == 3
        B.x_before{1} = B.x;
        B.y_before{1} = B.Y(:,B.indexStructShadowView - 1);
        B.x_before{2} = B.x;
        B.y_before{2} = B.Y(:,B.indexStructShadowView - 2);
    elseif (B.indexStructShadowView) > 3
        B.x_before{1} = B.x;
        B.y_before{1} = B.Y(:,B.indexStructShadowView - 1);
        B.x_before{2} = B.x;
        B.y_before{2} = B.Y(:,B.indexStructShadowView - 2);
        B.x_before{3} = B.x;
        B.y_before{3} = B.Y(:,B.indexStructShadowView - 3);
    end
elseif lm > 1 & m <= 1
    setappdata(B.hFig,'B',B);
    % для линий тени на несколько шагов после текущего спектра ЭПР
    if (lm - B.indexFilesShadowView) == 1
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView + 1}, B);
        B.x_after{1} = B.X;
        B.y_after{1} = B.Y(:,1);
    elseif (lm - B.indexFilesShadowView) == 2
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView + 1}, B);
        B.x_after{1} = B.X;
        B.y_after{1} = B.Y(:,1);
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView + 2}, B);
        B.x_after{2} = B.X;
        B.y_after{2} = B.Y(:,1);
    elseif (lm - B.indexFilesShadowView) > 2
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView + 1}, B);
        B.x_after{1} = B.X;
        B.y_after{1} = B.Y(:,1);
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView + 2}, B);
        B.x_after{2} = B.X;
        B.y_after{2} = B.Y(:,1);
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView + 3}, B);
        B.x_after{3} = B.X;
        B.y_after{3} = B.Y(:,1);
    end

    % для линий тени на несколько шагов ДО текущего спектра ЭПР
    if (B.indexFilesShadowView) == 2
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView - 1}, B);
        B.x_before{1} = B.X;
        B.y_before{1} = B.Y(:,1);
    elseif (B.indexFilesShadowView) == 3
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView - 1}, B);
        B.x_before{1} = B.X;
        B.y_before{1} = B.Y(:,1);
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView - 2}, B);
        B.x_before{2} = B.X;
        B.y_before{2} = B.Y(:,1);
    elseif (B.indexFilesShadowView) > 3
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView - 1}, B);
        B.x_before{1} = B.X;
        B.y_before{1} = B.Y(:,1);
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView - 2}, B);
        B.x_before{2} = B.X;
        B.y_before{2} = B.Y(:,1);
        [B.X,B.Y]=mload_EPR_data(B.fileFullList{B.indexFilesShadowView - 3}, B);
        B.x_before{3} = B.X;
        B.y_before{3} = B.Y(:,1);
    end
end



set(B.dataXY, 'XData',B.x, 'YData', B.y);
    
for i = 1:3
    set (B.dataXY_before(i), 'XData',B.x_before{i}, 'YData', B.y_before{i});
    set (B.dataXY_after(i), 'XData',B.x_after{i}, 'YData', B.y_after{i});
end

% Делаем все дополнительные прямые невидимыми
    if B.valEnableShadowView == 0
        for i = 1:3
            set (B.dataXY_before(i), 'Visible', 'off');
            set (B.dataXY_after(i), 'Visible', 'off');
        end
    end
    if B.valEnableShadowView == 1
        if B.valBefore > 0
            for i = 1:B.valBefore
                set (B.dataXY_before(i), 'Visible', 'on');
            end
        end
        if B.valAfter > 0
            for i = 1:B.valAfter
                set (B.dataXY_after(i), 'Visible', 'on');
            end
        end
    end

setappdata(B.hFig,'B',B);
end