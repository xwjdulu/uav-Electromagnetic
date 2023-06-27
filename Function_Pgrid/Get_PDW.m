function [UAV] = Get_PDW(UAV, Target)
%PDW������ش洢
% sigma = return_sigma_ZC(UAV.position,Target.position);    %%%% �����������ú�������return_sigma
sigma = 6*pi/180;
UAV.PDW.TOA = sigma*randn(1);                       %%%% ��ʱ�����洢Ŀ��Ĳ��������ڵ���
UAV.PDW.direction = derec(UAV.position,Target.position) + UAV.PDW.TOA;  %%%% ����ǶȲ������
if UAV.PDW.direction > 180
    UAV.PDW.direction = UAV.PDW.direction - 360;
elseif UAV.PDW.direction < -180 
    UAV.PDW.direction = UAV.PDW.direction + 360;
end
UAV.PDW.Fre = Target.Fre(Target.f0) + 0.2e6*randn(1);      %%%% Ƶ�ʲ������
UAV.PDW.Width = Target.Width + 0.1e-6*randn(1);  %%%% ����������

% UAV.tar = j;
% 
% flag_check = Check_target_ZC(UAV);   %%���Ŀ�ꣿ��
% if flag_check>0.5
%     UAV.PDW.Fre = 0;
%     UAV.PDW.Width = 0;  %%%% ����������
%     UAV.PDW.TOA = 0;                       %%%% ��ʱ�����洢Ŀ��Ĳ��������ڵ���
%     UAV.PDW.Angle = 0;
%     UAV.tar = 0;
% end