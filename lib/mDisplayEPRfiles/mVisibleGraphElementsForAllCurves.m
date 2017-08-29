function mVisibleGraphElementsForAllCurves (B,ON_OFF)
% Скрываем все графические элементы для пиков всех кривых
% ON_OFF = 'on' или 'off'- управляющее значение отображения или сокрытия элементов на
% графике

% B = getappdata(B.hFig,'B');

% Перебираем все имеющиеся редактированные кривые и соответствующие им пики
check = isfield(B,'Curve');
if check
    for cn = 1 : length(B.Curve)
        if isfield(B.Curve,'Peak')
            for i = 1 : length(B.Curve(cn).Peak)
                mVisibleGraphElementsForCurrentPeak (B,cn,i, ON_OFF);
            end
        end
    end
end

% setappdata(B.hFig,'B',B);
end