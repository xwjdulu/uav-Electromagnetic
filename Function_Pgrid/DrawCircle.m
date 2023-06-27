
function DrawCircle(x, y, r, Fre, nseg, S)
    %%x，y是圆心所在坐标，r是半径，nseg是边缘段数（越高，边缘越顺滑，建议100以上），S是plot的样式设置字符
  
    theta = 0 : (2 * pi / nseg) : (2 * pi);
    pline_x = r * cos(theta) + x;
    pline_y = r * sin(theta) + y;

%     plot(pline_x, pline_y, S, 'linewidth', 0.5);
    if Fre <= 1e9         %0 : 0.2e9 : 12e9
        fill(pline_x, pline_y, [0,1,0.8],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 2e9         
        fill(pline_x, pline_y, [0,1,0.4],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 3e9         
        fill(pline_x, pline_y, [0,1,0.2],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 4e9         
        fill(pline_x, pline_y, [0,1,0],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 5e9         
        fill(pline_x, pline_y, [0.2,1,0],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 6e9         
        fill(pline_x, pline_y, [0.4,1,0],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 7e9         
        fill(pline_x, pline_y, [0.8,1,0],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 8e9         
        fill(pline_x, pline_y, [1,1,0],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 9e9         
        fill(pline_x, pline_y, [1,0.8,0],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 10e9         
        fill(pline_x, pline_y, [1,0.4,0],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 11e9         
        fill(pline_x, pline_y, [1,0.2,0],'EdgeColor','none', 'facealpha', 0.15);
    elseif Fre <= 12e9         
        fill(pline_x, pline_y, [1,0,0],'EdgeColor','none', 'facealpha', 0.15);
    end