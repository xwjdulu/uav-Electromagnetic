addpath('Function_Pgrid')   

% clc;
clear all;

%单位km、时间s
%%初始化参数列表结构体
%---------------------------------------------------------------

Para.UAVnum = 4;                       %初始无人机总架数
Para.Targetnum = 4;                    %目标数
Para.Head = 0;                         %航向角
Para.Head_error = 2;                   %航向角误差 °
Para.uav_col = 0.8;                    %无人机之间安全距离

% Para.Area = [0 150;0 400];            % 站区范围 300km*300km
% Para.Unit = 10;                      % 网格间距    %每一个小单元格的规模Unit^2,大网格划分 20km
Para.Area = [0 20;0 20];            % 站区范围 20km*20km
Para.Unit = 2;                      % 网格间距    %每一个小单元格的规模Unit^2,大网格划分 2km
Para.MapL = Para.Area(1,2) - Para.Area(1,1);     %区域长度
Para.MapW = Para.Area(2,2) - Para.Area(2,1);     %区域宽度
Para.Unit_acc = 0.05;                 % 网格间距  小网格划分 50m

M = 2;              %1设置六边形网格，2设置正方形网格    
enter(M,Para);

