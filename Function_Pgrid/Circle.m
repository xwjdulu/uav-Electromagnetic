
function [Vi,theta] = CircleDraw(U_num,r,i)

a = pi/2/(U_num+1);
theta = a : a : a * U_num;
pline_x = r * cos(theta) + 0;
pline_y = r * sin(theta) + 0;
% plot(pline_x, pline_y, '.', 'markersize', 5);
V = zeros(U_num,2);  
for k = 1:1:U_num
    V(k,:) = [pline_x(k),pline_y(k)];
end
Vi = V(i,:);
theta = theta(i)*180/pi;
end
    
    