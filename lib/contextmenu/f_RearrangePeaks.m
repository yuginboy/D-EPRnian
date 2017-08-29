function f_RearrangePeaks(B)
% Функция перестройки или переупорядочения массива с пиками а точнее
% перезапись номеров пиков в поля Teg
B = getappdata(B.hFig,'B');
cn = B.currentCurveNumber;

if isfield(B,'Curve')
    if isfield(B.Curve,'Peak') && ~isempty(B.Curve)
        if ~isempty(B.Curve(cn).Peak) 
            for i = 1 : length(B.Curve(cn).Peak)
                if isnumeric(str2num( B.Curve(cn).Peak(i).Tag.Name ) ) %#ok<ST2NM>
                    B.Curve(cn).Peak(i).Tag.Name = num2str(i);
                end
                set(B.Curve(cn).Peak(i).Tag.hText, 'Position',B.Curve(cn).Peak(i).Tag.hText_Pos, 'string', [B.Curve(cn).TagName, ' : ', B.Curve(cn).Peak(i).Tag.Name]);
            end
        end
    end
end

setappdata(B.hFig,'B',B);
        
end