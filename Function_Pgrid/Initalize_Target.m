%%��ʼ��Ŀ������б�ṹ��
function [Target] = Initalize_Target(UAV, Para, Targetnum)
%λ�ã���ʼ�ٶȣ�����˶��ٶȣ���ɫ����ǰĿ�ĵ�λ�ã�������̽���ź���Զ���룬���ͣ����书�ʣ���Ƶ����ǰ��Ƶ
%�շ��������棬����, ���ֱ�־,�Ƿ񿪻����Ƿ񱻸���
%-----------------------------------------------------------------------------------------------------
empty_Target = struct('position',[],'velocity',[],'Vmax',0,'color',[0,0,0],'vp_position',[],'derection',[],'RS',[],'type',[],'Pow',0,'Fre',0,'f0',0,...
                        'Gt',0,'Width',0,'sign',0,'ison',1,'isdisturb',0);

%����Ⱥ��Ĵ洢�ṹ
Target = repmat(empty_Target,Targetnum,1); %repmat����������empty_UAV����
Targetposition = zeros(Targetnum,2);    %����ȫ0����
%Targettype = [0;1;3];  %Ŀ�����ͣ�1Ϊ200W/3.7GHzĿ�ꣻ0Ϊ10W/5.6GHzĿ��

%��ʼ����ز���
for i = 1:1:Targetnum 
%    Target(i).type = ceil(Targettype(i)/100);                   %Ŀ�����ͣ�0��1��
    Target(i).sign = 1;
    Target(i).Vmax = 0;%0.005;&0.01                           %����˶��ٶ�(km/s)
                                   %Ŀ����ɫ
     x = randi(Para.MapL)+Para.Unit*rand;if x > Para.MapL x = Para.MapL;end
      y = randi(Para.MapW)+Para.Unit*rand;if y > Para.MapW y = Para.MapW;end
        Target(i).position = [x,y];       %����1��2�е����������Ŀ���ʼλ��
        Targetposition(i,:) = Target(i).position;             %���յ�λ��
        Target(i).vp_position = [randi(Para.MapL),randi(Para.MapW)];    %����1��2�е����������Ŀ���˶�λ��
        Target(i).derection = derec(Target(i).position,Target(i).vp_position);
        Target(i).velocity = [cos(Target(i).derection * pi / 180),sin(Target(i).derection * pi / 180)];                   %��ʼ�ٶȣ�xy�����ٶȷ�Χ��Ϊ��-1��1)
        Target(i).Pow = 2.8e4;%2200e3;                                 %���书��     
       Target(i).Fre = 9.3e9;          %�̶���Ƶ
  %      Target(i).Fre = 3.0e9:0.1e9:3.0e9;                          %��Ƶ2.9GHz~3.1GHz
        Target(i).f0 = 1;
        Target(i).Gt = 0;                                     %�շ���������
        Target(i).Width = 27e-6;                               %����      �ظ�����1~10ms
        Target(i).bean_wd = 180;
        Target(i).ison = 1;
        Target(i).isdisturb = 0;
    if i<3                       %�̶��״�
        Target(i).color = [0,0,1];
        switch(i)
            case{1}
                Target(i).position = [15,4];
            case{2}
                Target(i).position = [18,15];
        end
        elseif i<4             %����ss�״�
            Target(i).color = [0,0,1];
            Target(i).Pow = 1.0e4:0.1e4:2.0e4;
            Target(i).Fre = 8.0e9;
        elseif i<5                   %����״�  �����״�10km��             
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