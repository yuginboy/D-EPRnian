function f_PutgeCurves(B)
% Функция удаления всех пиков со всех кривых. Полная очистка кривых от
% созданных на них регионов
B = getappdata(B.hFig,'B');
check = isfield(B,'Curve');
if check
    % Вводим параметр, который будет равен 0 как только не останется ни
    % одной кривой. Это мы узнаем по равентсву 0 длины length(B.Curve)
    chk = 1;
    
    while chk
        if  ~isempty(B.Curve)
            i = length(B.Curve);
            B.currentCurveNumber = i;
            setappdata(B.hFig,'B',B);
            f_CleanCurve(B);
            B = getappdata(B.hFig,'B');
            if isempty(B.Curve)
                chk = 0;
                disp ('Purging all edited Curves');
            end

        end
    end
end
B.currentCurveNumber = 0;
setappdata(B.hFig,'B',B);
end