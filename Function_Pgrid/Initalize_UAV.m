%%初始平台参数列表结构体
function [UAV, turn_angle, i] = Initalize_UAV(Para, UAVnum)
%位置，飞行高度，视距，初始速度，最快飞行速度，最小飞行速度，颜色，当前目的地位置，初始目的地位置，步径位置
%航向，转台方向，目标转台方向坐标，初始转角向量，目标转角向量(61/7)，全向转角向量计次，转台开关，转台速度，灵敏度，
%工作频段，当前工作频段，工作带宽，接收天线增益，天线波束覆盖角
%----------------------------------------------------------------------------------------------------------
empty_UAV = struct('position',[],'h',0,'R',0,'velocity',[],'Vmax',0,'Vmin',0,'color',[0,0,0],'vp_position',[],'ivp_position',[],'steptime',0,...
                     'derection',[],'turnderection',[],'vp_turnderection',[],'u',7,'u0',0,'uq',1,'turnswitch',1,'turn_v',0,'sen',0,...
                     'Fre',0,'f0',1,'Bw',0,'Gr',0,'bean_wd',0,'PDW',[]);

%建立群体的存储结构
UAV = repmat(empty_UAV,UAVnum,1); %repmat函数将矩阵empty_UAV复制
UAVposition = zeros(UAVnum,2);    %生成全0矩阵

%转台转角
% turn_angle = 135:-22.5:-135;
% turn_angle0 = 0:22.5:135;
% turn_angle1 = 112.5:-22.5:-135;
% turn_angle2 = -112.5:22.5:-22.5;

% turn_angle = 135:-22.5:-135;
% turn_angle0 = 0:22.5:135;
% turn_angle1 = 112.5:-22.5:-135;
% turn_angle2 = -112.5:22.5:-22.5;
% turn_angle0 = [turn_angle0 turn_angle1 turn_angle2];

turn_angle = [-80,-30,30,80];
%初始化PDW信息
PDW0.Fre = 0;       %频率
PDW0.Width = 0;     %脉宽
PDW0.TOA = 0;       %测向误差
PDW0.direction = 0; %方向角度
PDW0.Gt = 0;        %增益
PDW0.Pow = 0;       %功率

%初始化相关参数
for i = 1:1:UAVnum                         
%     if i == 1                            %区域左下角
%         UAV(i).position = [0.1,0.1]; 
%     elseif i == 2
%         UAV(i).position = [0.1,Para.uav_col]; 
%     elseif i == 3
%         UAV(i).position = [Para.uav_col,0.1]; 
%     elseif i == 4
%         UAV(i).position = [Para.uav_col,Para.uav_col];
%     end              
%    UAV(i).position = [randi(Para.MapL-1),randi(Para.MapW-1)]; %随机位置
     x = randi(Para.MapL)+Para.Unit*rand;if x>Para.MapL x = Para.MapL;end
     y = randi(Para.MapW)+Para.Unit*rand;if y>Para.MapW Y = Para.MapW;end
%      x = Para.MapL;
%      y = Para.MapW;
     UAV(i).position = [x,y];
    if i == 1                          %区域左上角右上角各两架
         UAV(i).position = [0.1,Para.MapW-0.1]; 
    elseif i == 2
        UAV(i).position = [0.1,Para.MapW-0.1-Para.uav_col]; 
     elseif i == 3
         UAV(i).position = [Para.MapL-0.1,Para.MapW-0.1];
    elseif i == 4
        UAV(i).position = [Para.MapL-0.1,Para.MapW-0.1-Para.uav_col];       
    end
%         UAV(i).position = [Para.MapL-0.1,Para.MapW-0.1-Para.uav_col];
%     end
%     if i == 1                            %区域上面中间排开
%         UAV(i).position = [Para.MapL/2-2*Para.uav_col,Para.MapW-Para.uav_col/2]; 
%     elseif i == 2
%         UAV(i).position = [Para.MapL/2-Para.uav_col,Para.MapW-Para.uav_col]; 
%     elseif i == 3
%         UAV(i).position = [Para.MapL/2+2*Para.uav_col,Para.MapW-Para.uav_col/2]; 
%     elseif i == 4
%         UAV(i).position = [Para.MapL/2+Para.uav_col,Para.MapW-Para.uav_col];
%     end      
%     if i == 1                            %区域左上角
%         UAV(i).position = [0.1,Para.MapW-0.1]; 
%     elseif i == 2
%         UAV(i).position = [0.1,Para.MapW-Para.uav_col-0.1]; 
%     elseif i == 3
%         UAV(i).position = [0.1+Para.uav_col,Para.MapW-0.1]; 
%     elseif i == 4
%         UAV(i).position = [0.1+Para.uav_col,Para.MapW-Para.uav_col-0.1];
%     elseif i == 5
%         UAV(i).position = [0.1+2*Para.uav_col,Para.MapW-0.1]; 
%     elseif i == 6
%         UAV(i).position = [0.1,Para.MapW-2*Para.uav_col-0.1];
%     elseif i == 7
%         UAV(i).position = [0.1+2*Para.uav_col,Para.MapW-Para.uav_col-0.1];
%     elseif i == 8
%         UAV(i).position = [0.1+Para.uav_col,Para.MapW-2*Para.uav_col-0.1];
%     elseif i == 9
%         UAV(i).position = [0.1+3*Para.uav_col,Para.MapW-0.1]; 
%     elseif i == 10
%         UAV(i).position = [0.1,Para.MapW-3*Para.uav_col-0.1];
%     elseif i == 11
%         UAV(i).position = [0.1+3*Para.uav_col,Para.MapW-Para.uav_col-0.1];
%     elseif i == 12
%         UAV(i).position = [0.1+Para.uav_col,Para.MapW-3*Para.uav_col-0.1];
%     end
%     UAV(i).derection = -45;
    UAV(i).derection = unifrnd(-180,180);
%     UAV(i).derection = 0;
    UAVposition(i,:) = UAV(i).position;   %最终点位置
%     UAV(i).h = 0.012;                      %飞行高度
    UAV(i).h = 1;                      %飞行高度 单位km
    UAV(i).R = 4.14*sqrt(UAV(i).h*1000);  %视距
    UAV(i).Vmax = 0.036;                     %最快飞行速度   120km/h 单位km/s
    UAV(i).Vmin = 0.022;                     %最小飞行速度    80km/h  单位km/s
    UAV(i).Fuel = 350;                    %燃油（最大航程km）
    UAV(i).Commdist = 20;              %通信距离，单位m
    UAV(i).turnR = 0.15;                   %无人机转向的最小转弯半径 单位km
    UAV(i).turnA = 180 / (pi * UAV(i).turnR / UAV(i).Vmin);          %无人机转向的最小转弯角
    UAV(i).color = [rand,rand,rand];      %颜色
%     [UAV(i).ivp_position, UAV(i).derection] = Circle(UAVnum,2.2*UAV(i).R,i);   %初始航点   %初始航向（小场景）
%     [UAV(i).ivp_position, UAV(i).derection] = Circle(UAVnum,UAV(i).R,i);   %初始航点   %初始航向（大场景）
    UAV(i).velocity = [cos(UAV(i).derection * pi / 180),sin(UAV(i).derection * pi / 180)];      %初始速度，xy方向速度范围均为（-1，1)
    UAV(i).turnderection = UAV(i).derection;     %初始转台方向
%     UAV(i).turnderection = UAV(i).derection + turn_angle(i);
%     if UAV(i).turnderection > 180
%         UAV(i).turnderection = UAV(i).turnderection - 360;
%     elseif UAV(i).turnderection < -180 
%         UAV(i).turnderection = UAV(i).turnderection + 360;
%     end
%     UAV(i).turn_v = [turn_angle0 turn_angle1 turn_angle2];       %转台角度 °/s
    UAV(i).sen = -75;                     %载荷接收灵敏度dBm
    UAV(i).Frequency = 0.2e9:0.2e9:18e9;          %载荷工作频段2GHz~6GHz,中间是波长
    UAV(i).Fre = UAV(i).Frequency(:,randperm(size(UAV(i).Frequency,2)));
%     UAV(i).Fre = UAV(i).Frequency;
    if i == 1
        UAV(i).f0 = 1;
    else
        UAV(i).f0 = UAV(i-1).f0 + fix((size(UAV(i).Fre,2) - 1) / UAVnum);
    end
    UAV(i).Bw = 2000e6;                    %载荷工作带宽
    UAV(i).Gr = 1;                        %载荷接收天线增益
    UAV(i).bean_wd = 50;                  %载荷天线波束覆盖角
    UAV(i).location_bean_wd = 6;          %载荷测向天线波束覆盖角
    UAV(i).PDW = PDW0;
end
end