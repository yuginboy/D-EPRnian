function mDisplayEPRfiles_resizeFcn_v_01 (B) 
% Перерисовыем и перемасштабируем фигуру при изменении ее размера
    B = getappdata(B.hFig,'B');
    pFig = get(B.hFig, 'Position'); 
    
    pAxes = get(B.hAxes, 'Position');
    
    scrsz = get(0,'ScreenSize'); % размеры экрана монитора
B.wscr =  pFig(3);
B.hscr = pFig(4);
B.waxe = B.wscr-B.subAxesWidth; % ширина осей
B.haxe = B.hscr-B.subAxesHeight - B.dh_forAxes; % высота осей

% Проверяем, нажата ли кнопка скрыть или открыть таблицу
chkHideTbl = get(B.tb_hideTable, 'Value');
if chkHideTbl == 1
% Пересчитываем размер таблицы о пиках
% B.axShiftY = B.axShiftY + B.tableSize (2) + B.btLastLineShft;
B.tableWinSize = [B.wscr - B.axShiftX - B.lb_borderSize, ...
    round(B.haxe*B.tableWinSizeK) - (B.axShiftY + B.dh_forAxes) ];
%     B.lb_borderSize - B.btLastLineShft - B.btDstBtw - B.btSmallTypeSize(2)]; % размер таблицы с информацией о пиках
end


B.pl = 0.5*(scrsz(3) - B.wscr);
B.pu = 0.5*(scrsz(4) - B.hscr);
% set(B.hFig, 'Position', [pl pu B.wscr B.hscr]);

% % Проверяем, нажата ли кнопка скрыть или открыть таблицу
% chkHideTbl = get(B.tb_hideTable, 'Value');



set(B.hAxes,'Position',[B.axShiftX (B.axShiftY + B.dh_forAxes) B.waxe B.haxe]);
    B.axPoligonX = [B.axShiftX, B.waxe+B.axShiftX, B.waxe+B.axShiftX, B.axShiftX];
    B.axPoligonY = [(B.axShiftY + B.dh_forAxes), (B.axShiftY + B.dh_forAxes), B.haxe+(B.axShiftY + B.dh_forAxes), B.haxe+(B.axShiftY + B.dh_forAxes)];
set(B.tb_hideTable,...
               'Position',[B.btLastLineShftX (B.axShiftY + B.dh_forAxes)+B.btLastLineShft - B.btSmallTypeSize(2), B.btSmallTypeSize]);
set(B.hb_about,...
               'Position',[B.btLastLineShftX, (B.axShiftY + B.dh_forAxes)+B.haxe+B.btFirstLineShft, B.btSmallTypeSize]);
set(B.ht_filename ,...
               'Position',[B.btLastLineShftX + B.btSmallTypeSize(1)+ B.btDstBtw B.btLastLineShft B.ht_filenameSize]);
% ---------
set(B.hb_info,...
               'Position',[B.btFirstLineShftX (B.axShiftY + B.dh_forAxes)+B.haxe+B.btFirstLineShft, B.btLongTypeSize ]);

set(B.hb_autoScale,...
               'Position',[B.btFirstLineShftX + B.btLongTypeSize(1) + B.btDstBtw, (B.axShiftY + B.dh_forAxes)+B.haxe+B.btFirstLineShft, B.btSmallTypeSize ]);
           prBtPos = get(B.hb_autoScale,'position');
set(B.hb_fixScale,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_fixScale,'position');
set(B.tb_RecZoom,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.tb_RecZoom,'position');
set(B.hb_Smooth,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_Smooth,'position');
set(B.eb_Smooth,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,B.btLongTypeSize(1)-prBtPos(3),0]);
set(B.eb_MagneticFieldCalibration,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),-(B.buttonHigh+B.btLastLineShft/2),...
               B.btLongTypeSize(1)-prBtPos(3),0]);
set(B.txt_MagneticFieldCalibration,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3)-80,-(B.buttonHigh+B.btLastLineShft+2),...
               B.btLongTypeSize(1)-prBtPos(3),0]);           
           prBtPos = get(B.eb_Smooth,'position');
set(B.hb_ViewSrcData,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,B.btSmallTypeSize(1)-B.btLongTypeSize(1),0]);
           prBtPos = get(B.hb_ViewSrcData,'position');
set(B.hb_BaseLine,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_BaseLine,'position');
set(B.tb_peakSearch,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.tb_peakSearch,'position');
set(B.tb_peakEdit,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
%-----------------            
           prBtPos = get(B.tb_peakEdit,'position');
set(B.hb_peakDel ,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_peakDel,'position');
set(B.hb_peakPrev,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_peakPrev,'position');
set(B.hb_peakNext,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           
           
%-----------------            
           prBtPos = get(B.hb_peakNext,'position');
set(B.hb_curveAdd,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_curveAdd,'position');
set(B.hb_curveDel,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_curveDel,'position');
set(B.hb_curvePrev,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_curvePrev,'position');
set(B.hb_curveNext,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_curveNext,'position');
set(B.hb_curvesPurge,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
           prBtPos = get(B.hb_curvesPurge,'position');
set(B.tb_storeData,...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0]);
%-----------------    
                prBtPosAx = get(B.hAxes,'position');
                prBtPos = get(B.hb_BaseLine,'position');
set(B.hb_options,...
              'Position',[B.waxe+B.axShiftX-B.btSmallTypeSize(1), prBtPos(2:end)]);
          prBtPos = get(B.hb_options,'position');
% Кнопка загрузки сплайн-коэффициентов из файла
set(B.hb_load,...
              'Position',[prBtPos(1)+prBtPos(3)+round(B.btDstBtw/2), prBtPos(2), B.btLongTypeSize]);
          prBtPos = get(B.hb_load,'position');
% Кнопка сохранения в файл *.png           
set(B.hb_save,...
               'Position',[prBtPos(1)+prBtPos(3)+round(B.btDstBtw/2), prBtPos(2), B.btLongTypeSize]); 
           prBtPos = get(B.hb_save,'position');
% Кнопка закрытия и передача данных на вывод  
set(B.hb_exit,...
               'Position',[prBtPos(1)+prBtPos(3)+round(B.btDstBtw/2), prBtPos(2), B.btLongTypeSize]);
           
% --------------------- ListBox
B.lb_High = round((B.haxe - (B.lb_borderSize*2))/3);

set(B.lb_dir,...
               'Position',[B.waxe+B.axShiftX+B.lb_borderSize, B.haxe+(B.axShiftY + B.dh_forAxes) - B.lb_High, B.lb_width, B.lb_High]); 
set(B.lb_files,...
               'Position',[B.waxe+B.axShiftX+B.lb_borderSize, B.haxe+(B.axShiftY + B.dh_forAxes)-2*B.lb_High-B.lb_borderSize, B.lb_width, B.lb_High]);
set(B.lb_struct,...
               'Position',[B.waxe+B.axShiftX+B.lb_borderSize, (B.axShiftY + B.dh_forAxes), B.lb_width, B.lb_High]);
% set(B.lb_text,...
%                'Position',[B.waxe+B.axShiftX+20+B.lb_width+20, (B.axShiftY + B.dh_forAxes), B.lb_width-40, B.haxe]);
    

           % Переопределяем коэффициенты масштаба на осях построения
           % графика
%             B.wgrReal = get(B.hAxes,'XLim');
%             B.hgrReal = get(B.hAxes,'YLim');
%             B.wgr = B.wgrReal(2) - B.wgrReal(1);
%             B.hgr = B.hgrReal(2) - B.hgrReal(1);
%             B.scw = B.waxe/B.wgr; % масштаб по x
%             B.sch = B.haxe/B.hgr; % масштаб по y


% Прорисовываем или заново создаем таблицу снизу под графиком линии:
% Проверяем была ли создана таблица:
check = isfield(B,'ui_mainBottomTableCurves');    

if B.tb_hideTable_ok == -1
    % Таблица должна показаться или создать ее заново
    
    if ~check
        setappdata(B.hFig,'B',B);
        mCreateMainTablesForCurvesWithRegions(B);
        B = getappdata(B.hFig,'B');
    else
        setappdata(B.hFig,'B',B);
        mVisibleMainTablesForCurvesWithRegions(B,'on');
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        mReScaleMainTablesForCurvesWithRegions(B);
        B = getappdata(B.hFig,'B');
    end
elseif B.tb_hideTable_ok == 1
    % Таблицу должны скрыть
    if check
        mVisibleMainTablesForCurvesWithRegions(B,'off');
    end
    
end

%=================================================================
            setappdata(B.hFig,'B',B);
            mUpdateScaleVars (B);
            B = getappdata(B.hFig,'B');
            
            drawnow;
            
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_pltData_v_02(B);
            B = getappdata(B.hFig,'B');
            
            drawnow;
            pause(0.1);
% if chkHideTbl == 1
% % Пересчитываем размер таблицы о пиках
% (B.axShiftY + B.dh_forAxes) = (B.axShiftY + B.dh_forAxes) - B.tableSize (2) - B.btLastLineShft;
% end
            
        setappdata(B.hFig,'B',B);

end