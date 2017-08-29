function h = drawArrow (x,y,props) 
% Рисуем стрелку на конце линии стандартными средствами MatLab
h = quiver( x(1),y(1),x(2)-x(1),y(2)-y(1), props{:} );
end