function mVisibleGraphElementsForCurrentCurve (B, ON_OFF)
% Скрываем все графические элементы для пиков данной, выделенной кривой
% Перед этим мы проверяем не подвергалась ли текущая кривая редактированию и
% процедуре поиска на ней пиков.
% ON_OFF = 'on' или 'off'- управляющее значение отображения или сокрытия элементов на
% графике
B = getappdata(B.hFig,'B');

% Ищем номер cn - current number для данной кривой из массива уже
% обработанных
check = isfield(B,'Curve');
if ~check
    return;
else
    if isempty(B.Curve)
        return;
    end
    cn = 1;
    while cn <= length(B.Curve)
        % Проверяем не является ли текущая кривая уже обработанной ранее 
        chk = mCompareDataWithCurrentCurve (B, cn);
        if chk
             
            break;
        else
            if cn == length(B.Curve)
                % Если не нашли совпадений (дошли до конца массива кривых), т.е. данная кривая не подвергалась
                % редактированию, то выйти из функции и вернуться в основную
                % программу
                return;
            end
        end
        cn = cn + 1;
    end
    
end
% Если данная кривая подвергалась редактированию (поиску
% пиков), то загружаем данные X,Y из памяти данной кривой. 
% Делаем это из-за того, что поиск пиков мог осуществляться для
% очень сглаженной кривой или кривой, к которой были применены
% особые фильтры сглаживания, отличные от значения по
% умолчанию.
B.x = B.Curve(cn).DataX;
B.y = B.Curve(cn).DataY;

% Проверяем, содержит ли данная кривая пики:
check = isfield(B.Curve,'Peak');
if check
    for i = 1 : length(B.Curve(cn).Peak)
        mVisibleGraphElementsForCurrentPeak (B,cn,i, ON_OFF);
    end
end

setappdata(B.hFig,'B',B);
end