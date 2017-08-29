function mDisplayEPRfiles_mousePushUpFcn_v_01 (B)
        B = getappdata(B.hFig,'B');
        B.recZoom = get(B.tb_RecZoom, 'Value');
        chkPeakEdit = get (B.tb_peakEdit, 'Value');
%         click = get(gcbf,'SelectionType');
%         disp(click);
if B.mip == 1 && B.recZoom == 1 && B.chkMouseInAxesPolygon
    B.wgrReal = sort([B.startRecPosition(1), B.endRecPosition(1)]);
    B.hgrReal = sort([B.startRecPosition(2), B.endRecPosition(2)]);
%     disp(B.wgrReal);
%     disp(B.hgrReal);
%     disp('----');
    if abs(B.wgrReal(1)-B.wgrReal(2)) > 0 && abs(B.hgrReal(1)-B.hgrReal(2)) > 0 ...
            && ~isnan(B.wgrReal(1)) && ~isnan(B.wgrReal(2)) ...
            && ~isnan(B.hgrReal(1)) && ~isnan(B.hgrReal(2))
                set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal, 'XLimMode', 'manual', 'YLimMode', 'manual');
    end
            B.wgrReal = get(B.hAxes,'XLim');
            B.hgrReal = get(B.hAxes,'YLim');
            B.wgr = B.wgrReal(2) - B.wgrReal(1);
            B.hgr = B.hgrReal(2) - B.hgrReal(1);
            B.scw = B.waxe/B.wgr; % масштаб по x
            B.sch = B.haxe/B.hgr; % масштаб по y
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_pltData_v_02(B);
            B = getappdata(B.hFig,'B');
            
end
if B.mip == 2
    % Right-button-click была зажата. Теперь рядом с указателем мышки
    % создадим контекстное меню для возможности выбора дальнейших действий
    
    if inpolygon(B.p(1), B.p(2), B.axPoligonX, B.axPoligonY) && B.key == 1
        set(B.cmenu, 'Position', B.p,'Visible', 'on');
        
    end
end

if B.mip == 3
    % опция по позиционированию графика по зажатой средней кнопке
    
    
end

if round(B.mip) == 4 && B.chkMouseInAxesPolygon
    % Работаем с измерением размера региона
    
    % После отжатия левой кнопки мышки переопределяем точку отсчета
    % смещения для региона:
    if chkPeakEdit
        cn = B.currentCurveNumber;
        i = B.currentPeakNumber;
        if i > 0 && cn > 0
            try
                B.Curve(cn).Peak(i).RegionSearchCoordOld = B.Curve(cn).Peak(i).RegionSearchCoord;
%                 setappdata(B.hFig,'B',B);
%                 mWriteDataToMainBottomTableCurves (B);
%                 B = getappdata(B.hFig,'B');
%                 setappdata(B.hFig,'B',B);
%                 mWriteDataToMainBottomTableRegion (B);
%                 B = getappdata(B.hFig,'B');
            catch
               
                disp('Please make a note of this problem and send it to the author address: yuginboy@gmail.com');
                disp('Error in DisplayEPRfiles_mousePushUpFcn_v_01');
                disp('EditPeak region mode is On');
                txt = sprintf('Curve Number = %d Peak Number = %d ', cn, i);
                disp(txt);
                txt = sprintf('-->> The program version is %s', B.verVar);
                disp(txt);
            end
        else
            
        end
        
        
    end
     
    B.key = 0;
    B.mip = 0;
end
%         axes(B.hAxes);
%         set(B.ht_coordinates, 'Visible', 'off');
        B.key = 0;
        B.mip = 0;
%         disp(['ButUp:mip=', num2str(B.mip)]);
        set(B.hFig, 'Pointer', 'arrow');
        
setappdata(B.hFig,'B',B);
mWriteDataToMainBottomTableCurves (B);
B = getappdata(B.hFig,'B');

setappdata(B.hFig,'B',B);
mWriteDataToMainBottomTableRegion (B);
B = getappdata(B.hFig,'B');

        setappdata(B.hFig,'B',B);
end