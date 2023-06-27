%生成虚拟航点坐标矩阵
function [Virtual_set,vk,vpx,vpy] = Get_Virtual_set(Para, UAV, MV)
% R = UAV(1).R;    %小场景
R = 3*UAV(1).R/2;    %大场景
if MV ==1
    [Virtual_set,vk] =Hexagon(R,Para.MapL,Para.MapW); 
    A = [0:pi/3:2*pi];
    vpx = R*cos(A);  
    vpy = R*sin(A);
else
    [Virtual_set,vk] =Square(R,Para.MapL,Para.MapW);  
    A = [pi/4:pi/2:(7*pi)/4];
    vpx = R*cos(A)*sqrt(2);  
    vpy = R*sin(A)*sqrt(2);
end