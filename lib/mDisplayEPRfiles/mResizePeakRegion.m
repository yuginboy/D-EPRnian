function mResizePeakRegion (B)
% Функция изменения размеров выбранного региона. 
% Перестройка левой, правой управляющих областей и заливка остальной части
% соответствующим цветом. Также пересчет всех соответствующих данному пику
% физических характеристик, как то: Io, Imax, dB и т.д.
 B = getappdata(B.hFig,'B');
 

 % Устанавливаем номер кривой и координаты всех возможных регионов данной
 % кривой
%  setappdata(B.hFig,'B',B);
%  [chk,chkL,chkR, chkC] = mCheckCursorPositionInPeakArea(B);
%  B = getappdata(B.hFig,'B');

 
%  set(B.hFig, 'Pointer', 'arrow');
 
 cn = B.currentCurveNumber;
 i = B.currentPeakNumber;

 setappdata(B.hFig,'B',B);
mUpdateScaleVars (B);
B = getappdata(B.hFig,'B');

dx = B.new_x - B.startRecPosition(1);
% disp(dx);
%  if chkC
%      set(B.hFig, 'Pointer', 'fleur');
%  end
%  if chkR
%      set(B.hFig, 'Pointer', 'right');
%  end
%  if chkL
%      set(B.hFig, 'Pointer', 'left');
%  end
%  
 
if B.mip == 4.3
    set(B.hFig, 'Pointer', 'fleur');
         % Если левой кнопкой мышки зажата центральная зона региона
         if B.Curve(cn).Peak(i).RegionSearchCoord(1) < B.Curve(cn).Peak(i).RegionSearchCoord(2)
           B.Curve(cn).Peak(i).RegionSearchCoord(1) =   B.Curve(cn).Peak(i).RegionSearchCoordOld(1) + dx;
           B.Curve(cn).Peak(i).RegionSearchCoord(2) =   B.Curve(cn).Peak(i).RegionSearchCoordOld(2) + dx;
          setappdata(B.hFig,'B',B);
         mMovePeakRegion (B);
          B = getappdata(B.hFig,'B');
         end
end

if B.mip == 4.2
    set(B.hFig, 'Pointer', 'right');
         % Если левой кнопкой мышки зажата правая ручка региона
         if B.Curve(cn).Peak(i).RegionSearchCoord(2) > B.Curve(cn).Peak(i).RegionSearchCoord(1)
             B.Curve(cn).Peak(i).RegionSearchCoord(2) =   B.Curve(cn).Peak(i).RegionSearchCoordOld(2) + dx;
              setappdata(B.hFig,'B',B);
              mMovePeakRegion (B);
%              mReCalcPeakRegion (B);
              B = getappdata(B.hFig,'B');
         end
end

if B.mip == 4.1
    set(B.hFig, 'Pointer', 'left');
         % Если левой кнопкой мышки зажата левая ручка региона
         if B.Curve(cn).Peak(i).RegionSearchCoord(1) < B.Curve(cn).Peak(i).RegionSearchCoord(2)
             B.Curve(cn).Peak(i).RegionSearchCoord(1) =   B.Curve(cn).Peak(i).RegionSearchCoordOld(1) + dx;
              setappdata(B.hFig,'B',B);
              mMovePeakRegion (B);
%              mReCalcPeakRegion (B);
              B = getappdata(B.hFig,'B');
         end
end


% if chkC
%      set(B.hFig, 'Pointer', 'fleur');
%      if B.mip == 4
%          % Если левой кнопкой мышки зажата ручка региона
%          if B.Curve(cn).Peak(i).RegionSearchCoord(1) < B.Curve(cn).Peak(i).RegionSearchCoord(2)
%            B.Curve(cn).Peak(i).RegionSearchCoord(1) =   B.Curve(cn).Peak(i).RegionSearchCoordOld(1) + dx;
%            B.Curve(cn).Peak(i).RegionSearchCoord(2) =   B.Curve(cn).Peak(i).RegionSearchCoordOld(2) + dx;
%           setappdata(B.hFig,'B',B);
% %          mReCalcPeakRegion (B);
%          mMovePeakRegion (B);
%           B = getappdata(B.hFig,'B');
%          end
%      end
%  end
%  if chkR
%      set(B.hFig, 'Pointer', 'right');
%          
% %      txt = sprintf('Curve N = %g , Peak N = %g', B.currentCurveNumber,B.currentPeakNumber);
% %      disp(txt);
%      if B.mip == 4
% %          OX_length = abs(B.Curve(cn).Peak(i).RegionSearchCoord(2) - B.Curve(cn).Peak(i).RegionSearchCoord(1))/0.9;
% %          w = 0.05*( B.wgr );
%          % Если левой кнопкой мышки зажата ручка региона
%          if B.Curve(cn).Peak(i).RegionSearchCoord(2) > B.Curve(cn).Peak(i).RegionSearchCoord(1)
%              B.Curve(cn).Peak(i).RegionSearchCoord(2) =   B.Curve(cn).Peak(i).RegionSearchCoordOld(2) + dx;
% %            B.Curve(cn).Peak(i).RegionSearchCoord(2) = B.new_x - 0.5*w;
%               setappdata(B.hFig,'B',B);
%              mReCalcPeakRegion (B);
%               B = getappdata(B.hFig,'B');
%          end
%      end
%  end
%  if chkL
%      set(B.hFig, 'Pointer', 'left');
%      if B.mip == 4
% %          OX_length = abs(B.Curve(cn).Peak(i).RegionSearchCoord(2) - B.Curve(cn).Peak(i).RegionSearchCoord(1))/0.9;
% %          w = 0.05*( B.wgr );
%          % Если левой кнопкой мышки зажата ручка региона
%          if B.Curve(cn).Peak(i).RegionSearchCoord(1) < B.Curve(cn).Peak(i).RegionSearchCoord(2)
%              B.Curve(cn).Peak(i).RegionSearchCoord(1) =   B.Curve(cn).Peak(i).RegionSearchCoordOld(1) + dx;
% %              disp(B.new_x - B.Curve(cn).Peak(i).RegionSearchCoord(1));
% %              B.Curve(cn).Peak(i).RegionSearchCoord(1) = B.new_x + 0.5*w;
%               setappdata(B.hFig,'B',B);
%              mReCalcPeakRegion (B);
%               B = getappdata(B.hFig,'B');
%          end
%      end
%  end
 
 setappdata(B.hFig,'B',B);
end