addpath('Function_Pgrid')   

% clc;
clear all;

%��λkm��ʱ��s
%%��ʼ�������б�ṹ��
%---------------------------------------------------------------

Para.UAVnum = 4;                       %��ʼ���˻��ܼ���
Para.Targetnum = 4;                    %Ŀ����
Para.Head = 0;                         %�����
Para.Head_error = 2;                   %�������� ��
Para.uav_col = 0.8;                    %���˻�֮�䰲ȫ����

% Para.Area = [0 150;0 400];            % վ����Χ 300km*300km
% Para.Unit = 10;                      % ������    %ÿһ��С��Ԫ��Ĺ�ģUnit^2,�����񻮷� 20km
Para.Area = [0 20;0 20];            % վ����Χ 20km*20km
Para.Unit = 2;                      % ������    %ÿһ��С��Ԫ��Ĺ�ģUnit^2,�����񻮷� 2km
Para.MapL = Para.Area(1,2) - Para.Area(1,1);     %���򳤶�
Para.MapW = Para.Area(2,2) - Para.Area(2,1);     %������
Para.Unit_acc = 0.05;                 % ������  С���񻮷� 50m

M = 2;              %1��������������2��������������    
enter(M,Para);

