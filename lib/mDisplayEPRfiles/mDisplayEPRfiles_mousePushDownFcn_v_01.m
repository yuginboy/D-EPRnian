function mDisplayEPRfiles_mousePushDownFcn_v_01 (B)
%         global B;
        B = getappdata(B.hFig,'B');
        B.recZoom = get(B.tb_RecZoom, 'Value');
        chkPeakEdit = get (B.tb_peakEdit, 'Value');
        
        setappdata(B.hFig,'B',B);
         [chk,chkL,chkR, chkC] = mCheckCursorPositionInPeakArea(B);
         B = getappdata(B.hFig,'B');
 
        B.mip = 0;
        click = get(B.hFig,'SelectionType');
        switch click
            case 'normal'
                if chkPeakEdit && chk
                    if chk
                        % Нажатие произошло в общей зоне региона
                        B.mip = 4;
                    end
                    if chkL
                        % Нажатие произошло в левой зоне региона
                        B.mip = 4.1;
                    end
                    if chkR
                     % Нажатие произошло в правой зоне региона
                        B.mip = 4.2;
                    end
                    if chkC
                     % Нажатие произошло в центральной зоне региона
                        B.mip = 4.3;
                    end
                else
                    B.mip = 1; % Left-button-click
                    set(B.hFig, 'Pointer', 'arrow');
                    set(B.ht_deltaH, 'Visible', 'off');
                    if B.recZoom == 1 && B.chkMouseInAxesPolygon
                        set(B.mcpRecZoom, 'Visible', 'on');
                    else 
                        set(B.mcpRecZoom, 'Visible', 'off');
                    end
                end
                
            case 'alt'
                B.mip = 2; % Right-button-click
                set(B.hFig, 'Pointer', 'arrow');
                if B.chkMouseInAxesPolygon
                    set(B.mcpRecMeasureY, 'Visible', 'on');
    %                 set(B.mcpFirstLineMeasureX, 'Visible', 'on');
    %                 set(B.mcpSecondLineMeasureX, 'Visible', 'on');
                    set(B.mcpFirstLineMeasureY, 'Visible', 'on');
                    set(B.mcpSecondLineMeasureY, 'Visible', 'on');
                end
            case 'extend'
                B.mip = 3; % Middle-button-click
                set(B.hFig, 'Pointer', 'fleur');
            otherwise
                B.mip = 0;
                set(B.hFig, 'Pointer', 'arrow');
        end
%         disp(['ButDown:mip=', num2str(B.mip)]);

%         setappdata(B.hFig,'B',B);
           
%     B.new_x = (B.p(1)-B.axShiftX + B.wgrReal(1)*B.scw)/B.scw;
%     B.new_y = (B.p(2)-B.axShiftY + B.hgrReal(1)*B.sch)/B.sch;
    

    
%     pFig = get(B.hFig, 'Position');
%     if pFig(3)<B.wscr
%         set(B.hFig, 'Resize', 'off');
%         set(B.hFig, 'Position', [pFig(1) pFig(2) B.wscr B.hscr]);
%         set(B.hFig, 'Resize', 'on');
%     end
%     if pFig(4)<B.hscr
%         set(B.hFig, 'Resize', 'off');
%         set(B.hFig, 'Position', [pFig(1) pFig(2) B.wscr B.hscr]);
%         set(B.hFig, 'Resize', 'on');
%     end
    
%     disp(B.mip);
    if B.mip == 3 
        % нажата средняя кнопка мыши
        
        % фиксируем центральную точку относительно которой будем
        % высчитывать сдвиг осей
        B.start_x = B.new_x;
        B.start_y = B.new_y;
        %disp(sprintf('%d , %d',B.start_x, B.start_y));
        B.wgrReal_start = B.wgrReal;
        B.hgrReal_start = B.hgrReal;
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_moveCurveOnAxis_v_01(B);
        B = getappdata(B.hFig,'B');
    else
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_pltData_v_02 (B);
        B = getappdata(B.hFig,'B');
    end
    
    switch click
            case 'normal'
               if chkPeakEdit && chk
                    if chk
                        % Нажатие произошло в общей зоне региона
                        B.mip = 4;
                    end
                    if chkL
                        % Нажатие произошло в левой зоне региона
                        B.mip = 4.1;
                    end
                    if chkR
                     % Нажатие произошло в правой зоне региона
                        B.mip = 4.2;
                    end
                    if chkC
                     % Нажатие произошло в центральной зоне региона
                        B.mip = 4.3;
                    end
                else
                    B.mip = 1; % Left-button-click
                    set(B.hFig, 'Pointer', 'arrow');
                end
                
            case 'alt'
                B.mip = 2; % Right-button-click
                set(B.hFig, 'Pointer', 'arrow');
                
            case 'extend'
                B.mip = 3; % Middle-button-click
                set(B.hFig, 'Pointer', 'fleur');
            otherwise
                B.mip = 0;
                set(B.hFig, 'Pointer', 'arrow');
    end
    
    
        
    setappdata(B.hFig,'B',B);
%         return;
end