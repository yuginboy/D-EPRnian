function f_DeletePeak(B)
% Функция удаления выделенного пика с кривой
B = getappdata(B.hFig,'B');
cn = B.currentCurveNumber;
i = B.currentPeakNumber;
if i > 0
    if ~isempty(B.Curve(cn).Peak)
        % Delete all graphical elements from the figure and hAxes:
        delete( B.Curve(cn).Peak(i).h_RegionBox );
        delete( B.Curve(cn).Peak(i).hL_RegionBox );
        delete( B.Curve(cn).Peak(i).hR_RegionBox );
        delete( B.Curve(cn).Peak(i).h_CurveArea );
        delete( B.Curve(cn).Peak(i).Tag.hText );
        delete( B.Curve(cn).Peak(i).P1.hText );
        delete( B.Curve(cn).Peak(i).P1.hLineVert );
        delete( B.Curve(cn).Peak(i).P2.hText );
        delete( B.Curve(cn).Peak(i).P2.hLineVert );
        delete( B.Curve(cn).Peak(i).Bo.hLineVert );
        delete( B.Curve(cn).Peak(i).Bo.hLineHorzTop );
        delete( B.Curve(cn).Peak(i).Bo.hLineHorzBot );
        delete( B.Curve(cn).Peak(i).Bo.hText );
        delete( B.Curve(cn).Peak(i).Imax.hText );
        delete( B.Curve(cn).Peak(i).dBmax.hLine );
        delete( B.Curve(cn).Peak(i).dBmax.hText );
        delete( B.Curve(cn).Peak(i).Io.hText );
        delete( B.Curve(cn).Peak(i).Text.hText );
         % delete all residual values:
        B.Curve(cn).Peak(i) = [];
        B.currentPeakNumber = 0;
        if isempty(B.Curve(cn).Peak) 

            B.Curve(cn) = [];
            B.currentCurveNumber = 0;

            if isempty(B.Curve)
                B.Curve = [];
            end

        end
    end
end
setappdata(B.hFig,'B',B);


        
end