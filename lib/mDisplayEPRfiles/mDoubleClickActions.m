function mDoubleClickActions(B)
 % По двойному нажатию мышки автомасштабируем кривую на графике
 B = getappdata(B.hFig,'B');
 chkPeakEdit = get (B.tb_peakEdit, 'Value');
if chkPeakEdit
    setappdata(B.hFig,'B',B);
    [chk,chkL,chkR, chkC] = mCheckCursorPositionInPeakArea(B);
    B = getappdata(B.hFig,'B');
    if chk
        % Если двойное нажатие произошло на области какого-то пика, то
        % автомасштабируем данный пик в окне просмотра
        
        % Пересчитываем область региона, чтобы затем провести
        % автомасштабирование
        setappdata(B.hFig,'B',B);  
        mReCalcPeakRegion(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);  
        mAutoScaleCurrentRegion(B);
        B = getappdata(B.hFig,'B');
        
        %disp('----------');
        %disp(get(B.hAxes, 'XLim'));
        %disp('----');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_pltData_v_02(B);
        B = getappdata(B.hFig,'B');
    else
%         % Пересчитываем область региона, чтобы перестроить высоты региона
%         setappdata(B.hFig,'B',B);  
%         mChangePeakRegionHeight (B);
%         B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);  
        mDisplayEPRfiles_autoScale_v_01(B);
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_pltData_v_02(B);
        B = getappdata(B.hFig,'B');
    end
else
    setappdata(B.hFig,'B',B);  
    mDisplayEPRfiles_autoScale_v_01(B);
    B = getappdata(B.hFig,'B');
    setappdata(B.hFig,'B',B);
    mDisplayEPRfiles_pltData_v_02(B);
    B = getappdata(B.hFig,'B');
end


setappdata(B.hFig,'B',B);            
end