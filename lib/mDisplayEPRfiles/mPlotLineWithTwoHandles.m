function hdl = mPlotLineWithTwoHandles(X,Y, B)
% функция рисования линии и специальных окружностей около концевых точек на ней
% Для рисования линии с ручным позиционированием ее концов с помощью кликов
% мышкой.
% X,Y - вектор координат двух конечных точек прямой

OX_length = (B.wgrReal(2) - B.wgrReal(1))/0.9;
% Определяем размер прямоугольника выделения над точками:
w = OX_length/20; % width
h = (B.hgrReal(2) - B.hgrReal(1))/10; % Height
% Рисуем линию между двумя точками:
hdl.hLine = plot(X,Y,'-o', 'Color', [130 55 176]/255, 'MarkerSize', 15, 'MarkerFaceColor', 'none','Clipping','on');
hdl.P0.Coor = [(X(2)+X(1))/2, (Y(2)+Y(1))/2];
hdl.P0.hPlot = plot(hdl.P0.Coor(1),hdl.P0.Coor(2),'+k', 'MarkerSize', 20);

str1 = sprintf('\n B = %0.5g Oe, I = %0.5g a.u.', B.Curve(cn).Peak(i).P2.Coor(1), B.Curve(cn).Peak(i).P2.Coor(2));
% str1 = ['\leftarrow', str1];
Xc = B.Curve(cn).Peak(i).P2.Coor(1) - 0.35*dX;
B.Curve(cn).Peak(i).P2.hText = text(Xc, B.Curve(cn).Peak(i).P2.Coor(2),str1,'Clipping','on');
B.Curve(cn).Peak(i).P2.hText_Pos = [Xc, B.Curve(cn).Peak(i).P2.Coor(2)];


x = X(1) - w/2;
y = Y(1) - h/2;
hdl.P1.xv =   [x; (x+w); (x+w); x ;  x];
hdl.P1.yv =   [y;   y;    y+h; y+h; y];
hdl.P1.h_DrawArea = patch('XData',hdl.P1.xv,'YData',hdl.P1.yv,...
    'EdgeColor', [0.1,0.5,0.7]+0.1,'LineStyle','-', 'FaceColor', [0.9,0.5,0.7], 'FaceAlpha', 0.5);

x = X(2) - w/2;
y = Y(2) - h/2;
hdl.P2.xv =   [x; (x+w); (x+w); x ;  x];
hdl.P2.yv =   [y;   y;    y+h; y+h; y];
hdl.P2.h_DrawArea = patch('XData',hdl.P2.xv,'YData',hdl.P2.yv,...
    'EdgeColor', [0.1,0.5,0.7]+0.1,'LineStyle','-', 'FaceColor', [0.9,0.5,0.7], 'FaceAlpha', 0.5);
% hdl.imPoint1 = impoint(B.hAxes, X(1),Y(1));
% hdl.imPoint2 = impoint(B.hAxes, X(2),Y(2));



end