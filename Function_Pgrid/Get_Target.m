%����Ŀ������
function [get_target, UAV] = Get_Target(UAV, Target)
 
%if ison == 0
%    get_target = 0;
%    UAV =  Get_PDW(UAV, Target);
get_target = 0;
range_uav_radar = norm(UAV.position - Target.position);        % Ŀ�������˻���ʵ�ʾ���
g = randsrc(1,1,[0 1;0.995 0.005]);
lo = randsrc(1,1,[0 1;0.992 0.008]);
if g == 1  %�龯��0.5%
    get_target = 1;
else
    if lo == 0   %©����0.8%
        if (range_uav_radar < UAV.R)   % 1�����Կ���Ŀ��
            if abs(UAV.Fre(UAV.f0) - Target.Fre(Target.f0)) < UAV.Bw
            temp = find(abs(UAV.Fre - Target.Fre) < UAV.Bw, 1);
            if ~isempty(temp)   % 2���ж�����Դ��Ƶ���Ƿ�����������
                Lr = 32.4 + 20*log10(Target.Fre/1e6) + 20*log10(range_uav_radar);
                P_send = 30 + 10*log10(Target.Pow);
                Lx = 0;
                P = P_send + Target.Gt - Lr + UAV.Gr + Lx;    % �źŵ������˻����ߵĹ��ʴ�С
                if (range_uav_radar < Target.RS)    % 3���źŹ��������˻�ϵͳ�����ȱȽϣ��źŹ��ʴ����յ��ź�
                    angle1 = abs(derec(UAV.position,Target.position)-UAV.turnderection);     %Ŀ�귽����ת̨�н�
                    if angle1 > 180
                        angle1 = abs(angle1 - 360);
                    end
                    angle2 = abs(derec(Target.position,UAV.position)-Target.derection);     %Ŀ�귽����ת̨�н�
                    if angle2 > 180
                        angle2 = abs(angle2 - 360);
                    end
                    if (angle1 < UAV.bean_wd) && (angle2 < Target.bean_wd)    % 4���ڲ�����Χ�������������
                        get_target = 1;
                        UAV = Get_PDW(UAV, Target);
                    end
                end
                end
            end
        end
    end
end
% get_target = 0;
end




            