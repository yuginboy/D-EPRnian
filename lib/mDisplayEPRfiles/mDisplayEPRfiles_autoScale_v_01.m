function mDisplayEPRfiles_autoScale_v_01 (B) 
% автоскалируем график чтобы он полностью занимал пространство на осях
    B = getappdata(B.hFig,'B');
    
    maxX = max(max(B.x));
    minX = min(min(B.x));
    
    maxY = max(max(B.y));
    minY = min(min(B.y));
    B.minYy = minY;
    B.maxYy = maxY;
    set(B.hAxes, 'XLim', [minX maxX], 'YLim', [minY maxY]);
    
    
    setappdata(B.hFig,'B',B);
    mUpdateScaleVars (B);
    B = getappdata(B.hFig,'B');
    
%     B.wgrReal = get(B.hAxes,'XLim');
%     B.hgrReal = get(B.hAxes,'YLim');
%     B.wgr = B.wgrReal(2) - B.wgrReal(1);
%     B.hgr = B.hgrReal(2) - B.hgrReal(1);
%     B.scw = B.waxe/B.wgr; % масштаб по x
%     B.sch = B.haxe/B.hgr; % масштаб по y
    
    setappdata(B.hFig,'B',B);
end