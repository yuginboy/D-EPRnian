function mCheckButtonStatusFunction(B)
% Функция проверки состояния togglebutton кнопок, чтобы при значении
% параметра Value= 1 или 0 автоматически менять иконку
B = getappdata(B.hFig,'B');
chk = get(B.hb_fixScale, 'Value');
if chk
    set(B.hb_fixScale, 'CData', imread('./icons/24x23/autoscale_pr.jpg'),...
               'TooltipString','Autoscale mode is Off');
else
    set(B.hb_fixScale, 'CData', imread('./icons/24x23/autoscale_n.jpg'),...
               'TooltipString','Autoscale mode is On');
end

chk = get(B.tb_RecZoom, 'Value');
if chk
    set(B.tb_RecZoom, 'CData', imread('./icons/24x23/rec_zoom_pr.jpg'),...
               'TooltipString','Rectangular zooming mode is On');
else
    set(B.tb_RecZoom,'CData', imread('./icons/24x23/rec_zoom_n.jpg'),...
               'TooltipString','Rectangular zooming mode is Off');
end

chk = get(B.tb_peakSearch, 'Value');
if chk
    set(B.tb_peakSearch, 'CData', imread('./icons/24x23/peak_search_pr.jpg'),...
               'TooltipString','Searching peak in the area view');
else
    set(B.tb_peakSearch, 'CData', imread('./icons/24x23/peak_search_n.jpg'),...
               'TooltipString','Automatic peak search in the area view');
end

chk = get(B.tb_peakEdit, 'Value');
if chk
    set(B.tb_peakEdit, 'CData', imread('./icons/24x23/peak_edit_pr.jpg'),...
               'TooltipString','Edit peak mode is On');
else
    set(B.tb_peakEdit, 'CData', imread('./icons/24x23/peak_edit_n.jpg'),...
               'TooltipString','Edit peak mode is Off');
end

setappdata(B.hFig,'B',B);
end