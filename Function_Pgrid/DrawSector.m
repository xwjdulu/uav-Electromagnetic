
function DrawSector(x, y, d, g, r, nseg, Fre, tar)
    %%x，y是圆心所在坐标，r是半径，nseg是边缘段数（越高，边缘越顺滑，建议100以上），S是plot的样式设置字符
    d = d * pi/180;
    g = g * pi/180;
    theta = d-g : (2 * pi / nseg) : d+g;
    pline_x = r * cos(theta) + x;
    pline_y = r * sin(theta) + y;
    if Fre <= 2.4e9         %0 : 0.2e9 : 12e9
        fill([x,pline_x,x], [y,pline_y,y], [0,0,1],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 3e9
        fill([x,pline_x,x], [y,pline_y,y], [0,1,1],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 3.6e9         
        fill([x,pline_x,x], [y,pline_y,y], [0,1,0],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 4.2e9         
        fill([x,pline_x,x], [y,pline_y,y], [0,1,1],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 4.8e9         
        fill([x,pline_x,x], [y,pline_y,y], [1,1,0],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 5.4e9         
        fill([x,pline_x,x], [y,pline_y,y], [1,0,0],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 6e9         
        fill([x,pline_x,x], [y,pline_y,y], [1,0,1],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 8e9         
        fill([x,pline_x,x], [y,pline_y,y], [1,1,0],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 9e9         
        fill([x,pline_x,x], [y,pline_y,y], [1,0.8,0],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 10e9         
        fill([x,pline_x,x], [y,pline_y,y], [1,0.4,0],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 11e9         
        fill([x,pline_x,x], [y,pline_y,y], [1,0.2,0],'EdgeColor','none', 'facealpha', 0.05);
    elseif Fre <= 12e9         
        fill([x,pline_x,x], [y,pline_y,y], [1,0,0],'EdgeColor','none', 'facealpha', 0.05);
    end
    if tar
        plot(pline_x, pline_y, 'y', 'linewidth', 1);
    end