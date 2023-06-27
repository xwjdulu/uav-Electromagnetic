%%��ʼƽ̨�����б�ṹ��
function [UAV, turn_angle, i] = Initalize_UAV(Para, UAVnum)
%λ�ã����и߶ȣ��Ӿ࣬��ʼ�ٶȣ��������ٶȣ���С�����ٶȣ���ɫ����ǰĿ�ĵ�λ�ã���ʼĿ�ĵ�λ�ã�����λ��
%����ת̨����Ŀ��ת̨�������꣬��ʼת��������Ŀ��ת������(61/7)��ȫ��ת�������ƴΣ�ת̨���أ�ת̨�ٶȣ������ȣ�
%����Ƶ�Σ���ǰ����Ƶ�Σ��������������������棬���߲������ǽ�
%----------------------------------------------------------------------------------------------------------
empty_UAV = struct('position',[],'h',0,'R',0,'velocity',[],'Vmax',0,'Vmin',0,'color',[0,0,0],'vp_position',[],'ivp_position',[],'steptime',0,...
                     'derection',[],'turnderection',[],'vp_turnderection',[],'u',7,'u0',0,'uq',1,'turnswitch',1,'turn_v',0,'sen',0,...
                     'Fre',0,'f0',1,'Bw',0,'Gr',0,'bean_wd',0,'PDW',[]);

%����Ⱥ��Ĵ洢�ṹ
UAV = repmat(empty_UAV,UAVnum,1); %repmat����������empty_UAV����
UAVposition = zeros(UAVnum,2);    %����ȫ0����

%ת̨ת��
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
%��ʼ��PDW��Ϣ
PDW0.Fre = 0;       %Ƶ��
PDW0.Width = 0;     %����
PDW0.TOA = 0;       %�������
PDW0.direction = 0; %����Ƕ�
PDW0.Gt = 0;        %����
PDW0.Pow = 0;       %����

%��ʼ����ز���
for i = 1:1:UAVnum                         
%     if i == 1                            %�������½�
%         UAV(i).position = [0.1,0.1]; 
%     elseif i == 2
%         UAV(i).position = [0.1,Para.uav_col]; 
%     elseif i == 3
%         UAV(i).position = [Para.uav_col,0.1]; 
%     elseif i == 4
%         UAV(i).position = [Para.uav_col,Para.uav_col];
%     end              
%    UAV(i).position = [randi(Para.MapL-1),randi(Para.MapW-1)]; %���λ��
     x = randi(Para.MapL)+Para.Unit*rand;if x>Para.MapL x = Para.MapL;end
     y = randi(Para.MapW)+Para.Unit*rand;if y>Para.MapW Y = Para.MapW;end
%      x = Para.MapL;
%      y = Para.MapW;
     UAV(i).position = [x,y];
    if i == 1                          %�������Ͻ����ϽǸ�����
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
%     if i == 1                            %���������м��ſ�
%         UAV(i).position = [Para.MapL/2-2*Para.uav_col,Para.MapW-Para.uav_col/2]; 
%     elseif i == 2
%         UAV(i).position = [Para.MapL/2-Para.uav_col,Para.MapW-Para.uav_col]; 
%     elseif i == 3
%         UAV(i).position = [Para.MapL/2+2*Para.uav_col,Para.MapW-Para.uav_col/2]; 
%     elseif i == 4
%         UAV(i).position = [Para.MapL/2+Para.uav_col,Para.MapW-Para.uav_col];
%     end      
%     if i == 1                            %�������Ͻ�
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
    UAVposition(i,:) = UAV(i).position;   %���յ�λ��
%     UAV(i).h = 0.012;                      %���и߶�
    UAV(i).h = 1;                      %���и߶� ��λkm
    UAV(i).R = 4.14*sqrt(UAV(i).h*1000);  %�Ӿ�
    UAV(i).Vmax = 0.036;                     %�������ٶ�   120km/h ��λkm/s
    UAV(i).Vmin = 0.022;                     %��С�����ٶ�    80km/h  ��λkm/s
    UAV(i).Fuel = 350;                    %ȼ�ͣ���󺽳�km��
    UAV(i).Commdist = 20;              %ͨ�ž��룬��λm
    UAV(i).turnR = 0.15;                   %���˻�ת�����Сת��뾶 ��λkm
    UAV(i).turnA = 180 / (pi * UAV(i).turnR / UAV(i).Vmin);          %���˻�ת�����Сת���
    UAV(i).color = [rand,rand,rand];      %��ɫ
%     [UAV(i).ivp_position, UAV(i).derection] = Circle(UAVnum,2.2*UAV(i).R,i);   %��ʼ����   %��ʼ����С������
%     [UAV(i).ivp_position, UAV(i).derection] = Circle(UAVnum,UAV(i).R,i);   %��ʼ����   %��ʼ���򣨴󳡾���
    UAV(i).velocity = [cos(UAV(i).derection * pi / 180),sin(UAV(i).derection * pi / 180)];      %��ʼ�ٶȣ�xy�����ٶȷ�Χ��Ϊ��-1��1)
    UAV(i).turnderection = UAV(i).derection;     %��ʼת̨����
%     UAV(i).turnderection = UAV(i).derection + turn_angle(i);
%     if UAV(i).turnderection > 180
%         UAV(i).turnderection = UAV(i).turnderection - 360;
%     elseif UAV(i).turnderection < -180 
%         UAV(i).turnderection = UAV(i).turnderection + 360;
%     end
%     UAV(i).turn_v = [turn_angle0 turn_angle1 turn_angle2];       %ת̨�Ƕ� ��/s
    UAV(i).sen = -75;                     %�غɽ���������dBm
    UAV(i).Frequency = 0.2e9:0.2e9:18e9;          %�غɹ���Ƶ��2GHz~6GHz,�м��ǲ���
    UAV(i).Fre = UAV(i).Frequency(:,randperm(size(UAV(i).Frequency,2)));
%     UAV(i).Fre = UAV(i).Frequency;
    if i == 1
        UAV(i).f0 = 1;
    else
        UAV(i).f0 = UAV(i-1).f0 + fix((size(UAV(i).Fre,2) - 1) / UAVnum);
    end
    UAV(i).Bw = 2000e6;                    %�غɹ�������
    UAV(i).Gr = 1;                        %�غɽ�����������
    UAV(i).bean_wd = 50;                  %�غ����߲������ǽ�
    UAV(i).location_bean_wd = 6;          %�غɲ������߲������ǽ�
    UAV(i).PDW = PDW0;
end
end