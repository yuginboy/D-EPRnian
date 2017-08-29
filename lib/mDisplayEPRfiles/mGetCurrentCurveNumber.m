function [cn, withPeaks] = mGetCurrentCurveNumber(B)
% Функция поиска соответствующей кривой из списка уже отредактированных
% Возвращает номер данной кривой и значение withPeaks = 1, если на данной
% кривой уже имеются пики
withPeaks = 0;
cn = 0;
% Ищем номер cn - current number для данной кривой из массива уже
% обработанных
check = isfield(B,'Curve');
if ~check
    return;
else
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
                cn = 0;
                return;
            end
        end
        cn = cn + 1;
    end
    
end

% Проверяем, содержит ли данная кривая пики:
check = isfield(B.Curve,'Peak');
if check
    withPeaks = 1;
end
end