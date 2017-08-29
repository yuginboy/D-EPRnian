function f_ActivateRightClicMenu(B)
% Функция по активации меню по правому клику мышки на окошках с файлами или
% структурой. Т.е. делаем меню активным, если будет обнаружено наличие
% соответствующих данных в данных полях: файлы с данными ЭПР или структуры
% данных ЭПР.
B = getappdata(B.hFig,'B');

% Контекстное меню для файлов
if ~isempty(B.fileFullList)
    if isfield(B, 'masterCurve')
        if isempty(B.masterCurve)
            B.cmenu.lb_files.pmPastProperties.Visible = 'off';
            B.cmenu.lb_files.pmPastProperties.Enable = 'off';
        else
            B.cmenu.lb_files.pmPastProperties.Visible = 'on';
            B.cmenu.lb_files.pmPastProperties.Enable = 'on';
        end
    end
    if isfield(B, 'Curve')
        cn = B.currentCurveNumber;
        %disp(cn);
        if cn > 0
            if ~isempty(B.Curve(cn))
                B.cmenu.lb_files.pmCopyProperties.Visible = 'on';
                B.cmenu.lb_files.pmCopyProperties.Enable = 'on';
            else
                B.cmenu.lb_files.pmCopyProperties.Visible = 'on';
                B.cmenu.lb_files.pmCopyProperties.Enable = 'off';
            end
        else
            B.cmenu.lb_files.pmCopyProperties.Visible = 'on';
            B.cmenu.lb_files.pmCopyProperties.Enable = 'off';
        end
    end
%     disp((B.cmenu.lb_struct.pmCopyProperties));
else
    B.cmenu.lb_files.pmPastProperties.Visible = 'on';
    B.cmenu.lb_files.pmPastProperties.Enable = 'off';
    B.cmenu.lb_files.pmCopyProperties.Visible = 'on';
    B.cmenu.lb_files.pmCopyProperties.Enable = 'off';
end

% Контекстное меню для структуры
[m,n] = size(B.alpha);
if m>1
    
    if isfield(B, 'masterCurve')
        if isempty(B.masterCurve)
            B.cmenu.lb_struct.pmPastProperties.Visible = 'off';
            B.cmenu.lb_struct.pmPastProperties.Enable = 'off';
        else
            B.cmenu.lb_struct.pmPastProperties.Visible = 'on';
            B.cmenu.lb_struct.pmPastProperties.Enable = 'on';
        end
    end
    if isfield(B, 'Curve')
        cn = B.currentCurveNumber;
        %disp(cn);
        if cn > 0
            if ~isempty(B.Curve(cn))
                B.cmenu.lb_struct.pmCopyProperties.Visible = 'on';
                B.cmenu.lb_struct.pmCopyProperties.Enable = 'on';
            else
                B.cmenu.lb_struct.pmCopyProperties.Visible = 'on';
                B.cmenu.lb_struct.pmCopyProperties.Enable = 'off';
            end
        else
            B.cmenu.lb_struct.pmCopyProperties.Visible = 'on';
            B.cmenu.lb_struct.pmCopyProperties.Enable = 'off';
        end
    end
%     disp((B.cmenu.lb_struct.pmCopyProperties));
else
    B.cmenu.lb_struct.pmPastProperties.Visible = 'on';
    B.cmenu.lb_struct.pmPastProperties.Enable = 'off';
    B.cmenu.lb_struct.pmCopyProperties.Visible = 'on';
    B.cmenu.lb_struct.pmCopyProperties.Enable = 'off';
end

setappdata(B.hFig,'B',B);
        
end