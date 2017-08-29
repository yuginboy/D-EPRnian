function out = mGetSelectedDataFromCurrentPeak (B, cn, i, strValue)
% Функция получения значения выбранного поля данных strValue из структуры
% сохраненной в каждом отдельном пике Peak
% К примеру значение поля 'Imax' или 'dB (Gs)'
%
%{'Curve ID','Curve Name','Start','End','BG Type', 'Av Width','Offset','G-faktor','Imax','Bo (Gs)','dB (Gs)','Area','Io',...
%             'automatic:','left Bo', 'left Io', 'right Bo', 'right Io',...
%             'manual:','left Bo', 'left Io', 'right Bo', 'right Io'};
if cn < 1
    cn = 1;
end
if i < 1
    i = 1;
end


switch strValue
    case 'Start'
        out = B.Curve(cn).Peak(i).RegionSearchCoord(1);
    case 'End'
        out = B.Curve(cn).Peak(i).RegionSearchCoord(2);
    case 'BG Type'
        out = 'Linear';
    case 'Av Width'
        out = 0;
    case 'Offset'
        out = B.Curve(cn).Peak(i).yShift;
    case 'G-faktor'
        out = B.Curve(cn).Peak(i).G.Coor;
    case 'Imax'
        out = B.Curve(cn).Peak(i).Imax.Coor;
    case 'Bo' 
        out = B.Curve(cn).Peak(i).Bo.Coor;
    case 'dB'
        out = B.Curve(cn).Peak(i).dBmax.Coor;
    case 'Area'
        out = B.Curve(cn).Peak(i).Area.TotalVal;
    case 'Io'    
        out = B.Curve(cn).Peak(i).Io.Coor;
    case 'auto left Bo'
        out = B.Curve(cn).Peak(i).P1.Coor(1);
    case 'auto left Io'
        out = B.Curve(cn).Peak(i).P1.Coor(2);
    case 'auto right Bo'
        out = B.Curve(cn).Peak(i).P2.Coor(1);
    case 'auto right Io'
        out = B.Curve(cn).Peak(i).P2.Coor(2);
    case 'manual left Bo'
        out = B.Curve(cn).Peak(i).P1.Coor(1);
    case 'manual left Io'
        out = B.Curve(cn).Peak(i).P1.Coor(2);
    case 'manual right Bo'
        out = B.Curve(cn).Peak(i).P2.Coor(1);
    case 'manual right Io'
        out = B.Curve(cn).Peak(i).P2.Coor(2);
    otherwise
        out = '--';
end
out = {out};
end