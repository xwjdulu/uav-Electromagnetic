%%初始化目标参数列表结构体
function [Target] = Initalize_Target(UAV, Para, Targetnum)
%位置，初始速度，最大运动速度，颜色，当前目的地位置，传感器探测信号最远距离，类型，发射功率，载频，当前载频
%收发天线增益，脉宽, 发现标志,是否开机，是否被干扰
%-----------------------------------------------------------------------------------------------------
empty_Target = struct('position',[],'velocity',[],'Vmax',0,'color',[0,0,0],'vp_position',[],'derection',[],'RS',[],'type',[],'Pow',0,'Fre',0,'f0',0,...
                        'Gt',0,'Width',0,'sign',0,'ison',1,'isdisturb',0);

%建立群体的存储结构
Target = repmat(empty_Target,Targetnum,1); %repmat函数将矩阵empty_UAV复制
Targetposition = zeros(Targetnum,2);    %生成全0矩阵
%Targettype = [0;1;3];  %目标类型，1为200W/3.7GHz目标；0为10W/5.6GHz目标

%初始化相关参数
for i = 1:1:Targetnum 
%    Target(i).type = ceil(Targettype(i)/100);                   %目标类型（0或1）
    Target(i).sign = 1;
    Target(i).Vmax = 0;%0.005;&0.01                           %最快运动速度(km/s)
                                   %目标颜色
     x = randi(Para.MapL)+Para.Unit*rand;if x > Para.MapL x = Para.MapL;end
      y = randi(Para.MapW)+Para.Unit*rand;if y > Para.MapW y = Para.MapW;end
        Target(i).position = [x,y];       %生成1行2列的随机数，即目标初始位置
        Targetposition(i,:) = Target(i).position;             %最终点位置
        Target(i).vp_position = [randi(Para.MapL),randi(Para.MapW)];    %生成1行2列的随机数，即目标运动位置
        Target(i).derection = derec(Target(i).position,Target(i).vp_position);
        Target(i).velocity = [cos(Target(i).derection * pi / 180),sin(Target(i).derection * pi / 180)];                   %初始速度，xy方向速度范围均为（-1，1)
        Target(i).Pow = 2.8e4;%2200e3;                                 %发射功率     
       Target(i).Fre = 9.3e9;          %固定载频
  %      Target(i).Fre = 3.0e9:0.1e9:3.0e9;                          %载频2.9GHz~3.1GHz
        Target(i).f0 = 1;
        Target(i).Gt = 0;                                     %收发天线增益
        Target(i).Width = 27e-6;                               %脉宽      重复周期1~10ms
        Target(i).bean_wd = 180;
        Target(i).ison = 1;
        Target(i).isdisturb = 0;
    if i<3                       %固定雷达
        Target(i).color = [0,0,1];
        switch(i)
            case{1}
                Target(i).position = [15,4];
            case{2}
                Target(i).position = [18,15];
        end
        elseif i<4             %机动ss雷达
            Target(i).color = [0,0,1];
            Target(i).Pow = 1.0e4:0.1e4:2.0e4;
            Target(i).Fre = 8.0e9;
        elseif i<5                   %火控雷达  机动雷达10km内             
            Target(i).color = [0,0,1];
            Target(i).Fre = 3.0e9; 
            Target(i).Pow = 0.75e3;
            xx = Target(3).position(1) + 5 -randi(10);
            yy = Target(3).position(2) + 5 -randi(10);
            if xx > Para.MapL xx = Para.MapL;end
            if yy > Para.MapW yy = Para.MapW;end
            if xx < 0 xx = 0;end
            if xx < 0 yy = 0;end
            Target(i).position = [xx,yy];
    end
    Target(i).RS = PowerR(i);
end