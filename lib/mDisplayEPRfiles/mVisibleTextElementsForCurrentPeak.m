function mVisibleTextElementsForCurrentPeak (B,cn,i, ON_OFF)
% Скрываем все тестовые элементы для выбранного пика данной кривой
% ON_OFF = 'on' или 'off'- управляющее значение отображения или сокрытия элементов на
% графике

% B = getappdata(B.hFig,'B');

% Может быть тег не трогать, посмотрим по обстоятельствам.
% set (B.Curve(cn).Peak(i).Tag.hText, 'Visible', ON_OFF);

set (B.Curve(cn).Peak(i).P1.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).P2.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Bo.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Imax.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).dBmax.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Io.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Text.hText, 'Visible', ON_OFF);

% setappdata(B.hFig,'B',B);
end