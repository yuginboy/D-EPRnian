function mControlPeakTextElementsFromViewScale(B)
% Функция сокрытия или наоборот отображения текстовых надписей (элементов)
% пиков в зависимости от того, какой масштаб выбран в окне просмотра. Если
% масштаб окна просмотра слишком большой, т.е. сам размер региона пика в
% сравнении с размером области просмотра мал (будем считать меньше 50%), то
% тогда скрываем все текстовые элементы. Может быть оставим лишь надпись
% номера данного пика
% B = getappdata(B.hFig,'B');

cn = B.currentCurveNumber;
viewArea = B.wgr*B.hgr;

if cn > 0
    % Проверяем, содержит ли данная кривая пики:
    check = isfield(B.Curve,'Peak');
    if check
        for i = 1 : length(B.Curve(cn).Peak)
            w = abs(B.Curve(cn).Peak(i).h_RegionBox_xv(2)-B.Curve(cn).Peak(i).h_RegionBox_xv(1));
            h = abs(B.Curve(cn).Peak(i).h_RegionBox_yv(2)-B.Curve(cn).Peak(i).h_RegionBox_yv(3));
            if B.Curve(cn).Peak(i).RegionBoxArea > 0.5*viewArea && w > 0.3*B.wgr && h > 0.3*B.hgr
                mVisibleTextElementsForCurrentPeak (B,cn,i, 'ON');
            else
                mVisibleTextElementsForCurrentPeak (B,cn,i, 'OFF');
            end
        end
    end
end

% setappdata(B.hFig,'B',B);
end