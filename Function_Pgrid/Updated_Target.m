%Ŀ���������
function [Target, Targetposition, Signal] = Updated_Target(Targetnum, Target, UAV, Para, t, TT, Signal, w) 
%Ŀ���ٶȸ���
for j = 1:1:Targetnum
    %Ŀ������˶�
    if ~isempty(Target(j).vp_position)
        Target(j).velocity = w*Target(j).velocity + (Target(j).vp_position - Target(j).position);
        dist = sqrt(sum((Target(j).velocity).^2,2)); %�ٶ�ģֵ
        if dist > Target(j).Vmax %����ٶȿ�ͽ���
            Target(j).velocity = Target(j).Vmax * Target(j).velocity / dist;
        end
        Target(j).position = Target(j).position + Target(j).velocity; %��λ������
        Targetposition(j,:) = Target(j).position; %����λ��
    elseif sqrt(sum((Target(j).vp_position - UATargetV(j).position).^2,2)) < 1
        Target(j).vp_position = [randi(Para.MapL),randi(Para.MapW)];
    end
        
    %Ŀ��Эͬ�����˶�
%     if Target(j).type == 0
%         if ~isempty(Target(j).vp_position)
%             Target(j).velocity = w*Target(j).velocity + (Target(j).vp_position - Target(j).position);
%             dist = sqrt(sum((Target(j).velocity).^2,2)); %�ٶ�ģֵ
%             if dist > Target(j).Vmax %����ٶȿ�ͽ���
%                 Target(j).velocity = Target(j).Vmax * Target(j).velocity / dist;
%             end
%             Target(j).position = Target(j).position + Target(j).velocity; %��λ������
%             Targetposition(j,:) = Target(j).position; %����λ��
%         elseif sqrt(sum((Target(j).vp_position - Target(j).position).^2,2)) < 1
%             Target(j).vp_position = [randi(Para.MapL),randi(Para.MapW)];
%         end
%     else
%         if ~isempty(Target(j-1).vp_position)
%             Target(j).velocity = w*Target(j).velocity + (Target(j).vp_position - Target(j).position);
%             dist = sqrt(sum((Target(j).velocity).^2,2)); %�ٶ�ģֵ
%             if dist > Target(j).Vmax %����ٶȿ�ͽ���
%                 Target(j).velocity = Target(j).Vmax * Target(j).velocity / dist;
%             end
%             Target(j).position = Target(j).position + Target(j).velocity; %��λ������
%             Targetposition(j,:) = Target(j).position; %����λ��
%         elseif sqrt(sum((Target(j-1).vp_position - Target(j-1).position).^2,2)) < 1
%             Target(j).vp_position = Circleposition(Target(j-1).vp_position(1), Target(j-1).vp_position(2), 0, 5000, 10, 0);
%         end
%     end
end
%Ŀ��������Ĭ���
% Ŀ��Ƶ�ʽر�
for j = 1:1:Targetnum
    Target(j).f0 = randi(size(Target(j).Fre,2));
%     Target(j).f0 = Target(j).f0 + 1;
%     if mod(Target(j).f0,size(Target(j).Fre,2)+1)==0
%         Target(j).f0 = 1;
%     end
    Target(j).RS = PowerR(j);
end
%Ŀ����������/����Ӱ��
% if mod(t,TT) == 0
if mod(t,randi([2,10])) == 0
    Signal = ~Signal;
end
for j = 1:1:Targetnum
    if Target(j).type == 0
        Signal = Signal;
        Signal = 1;
%         ������֪�뾶
        if Signal
            DrawSector(Targetposition(j,1),Targetposition(j,2),Target(j).derection,Target(j).bean_wd,Target(j).RS,100,Target(j).Fre(Target(j).f0),1);
        end
    else
        Signal = ~Signal;
        Signal = 1;
        %������֪�뾶
        if Signal
            DrawSector(Targetposition(j,1),Targetposition(j,2),Target(j).derection,Target(j).bean_wd,Target(j).RS,100,Target(j).Fre(Target(j).f0),1);
        end
    end
end
Signal = ~Signal;
Signal = 1;

