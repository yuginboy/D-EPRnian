function f_UpdateScaleVars (B) 
% переопределяем изменившиеся переменные вьювера (окна отображения графика)
    B = getappdata(B.hFig,'B');
    
%     if verLessThan('matlab', '8.4') % R2014b
%             try    % R2008a and later
%             catch % R2007b and earlier
%             end
%     else
%          set(B.hAxes, 'Clipping','on', 'ClippingStyle', 'rectangle');
%     end
    set(B.hAxes, 'Clipping','on', 'ClippingStyle', 'rectangle');
    
    B.wgrReal = get(B.hAxes,'XLim');
    B.hgrReal = get(B.hAxes,'YLim');
    B.wgr = B.wgrReal(2) - B.wgrReal(1);
    B.hgr = B.hgrReal(2) - B.hgrReal(1);
    B.scw = B.waxe/B.wgr; % масштаб по x
    B.sch = B.haxe/B.hgr; % масштаб по y
    
%     % Скрываем если надо текстовые надписи на пиках в зависимости от
%     % масштаба в окне просмотра
%     chkPeakEdit = get (B.tb_peakEdit, 'Value');
%     if chkPeakEdit
%         setappdata(B.hFig,'B',B);
%         mControlPeakTextElementsFromViewScale(B);
%         B = getappdata(B.hFig,'B');
%     end
    
    setappdata(B.hFig,'B',B);
end