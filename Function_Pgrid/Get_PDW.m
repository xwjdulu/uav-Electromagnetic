function [UAV] = Get_PDW(UAV, Target)
%PDW结果返回存储
% sigma = return_sigma_ZC(UAV.position,Target.position);    %%%% 测向误差，后面用函数代替return_sigma
sigma = 6*pi/180;
UAV.PDW.TOA = sigma*randn(1);                       %%%% 暂时用来存储目标的测向误差，便于调试
UAV.PDW.direction = derec(UAV.position,Target.position) + UAV.PDW.TOA;  %%%% 方向角度测量结果
if UAV.PDW.direction > 180
    UAV.PDW.direction = UAV.PDW.direction - 360;
elseif UAV.PDW.direction < -180 
    UAV.PDW.direction = UAV.PDW.direction + 360;
end
UAV.PDW.Fre = Target.Fre(Target.f0) + 0.2e6*randn(1);      %%%% 频率测量结果
UAV.PDW.Width = Target.Width + 0.1e-6*randn(1);  %%%% 脉宽测量结果

% UAV.tar = j;
% 
% flag_check = Check_target_ZC(UAV);   %%检测目标？？
% if flag_check>0.5
%     UAV.PDW.Fre = 0;
%     UAV.PDW.Width = 0;  %%%% 脉宽测量结果
%     UAV.PDW.TOA = 0;                       %%%% 暂时用来存储目标的测向误差，便于调试
%     UAV.PDW.Angle = 0;
%     UAV.tar = 0;
% end