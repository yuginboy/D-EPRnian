function f_CleanCurve(B)
% Функция удаления всех пиков с выделенной кривой
B = getappdata(B.hFig,'B');
cn = B.currentCurveNumber;
% Ищем номер cn - current number для данной кривой из массива уже
% обработанных
check = isfield(B,'Curve');
if check  && cn > 0
    if ~isempty(B.Curve)
        if isfield(B.Curve,'Peak')
            chk = 1;
            while chk
                if  ~isempty(B.Curve(cn).Peak)
                    i = length(B.Curve(cn).Peak);
                    B.currentPeakNumber = i;
                    setappdata(B.hFig,'B',B);
                    f_DeletePeak(B);
                    B = getappdata(B.hFig,'B');
                    if ~isempty(B.Curve)
                        if B.currentCurveNumber > 0
                        if isempty(B.Curve(cn).Peak)
                            chk = 0;
                        end
                        else
                            chk = 0;
                        end
                    else
                        chk = 0;
                    end
                    
                end
            end
        end
    end
end
B.currentCurveNumber = 0;
setappdata(B.hFig,'B',B);
end