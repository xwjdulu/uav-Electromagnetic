%搜索目标条件
function [get_target, UAV] = Get_Target(UAV, Target)
 
%if ison == 0
%    get_target = 0;
%    UAV =  Get_PDW(UAV, Target);
get_target = 0;
range_uav_radar = norm(UAV.position - Target.position);        % 目标与无人机的实际距离
g = randsrc(1,1,[0 1;0.995 0.005]);
lo = randsrc(1,1,[0 1;0.992 0.008]);
if g == 1  %虚警率0.5%
    get_target = 1;
else
    if lo == 0   %漏检率0.8%
        if (range_uav_radar < UAV.R)   % 1、可以看到目标
            if abs(UAV.Fre(UAV.f0) - Target.Fre(Target.f0)) < UAV.Bw
            temp = find(abs(UAV.Fre - Target.Fre) < UAV.Bw, 1);
            if ~isempty(temp)   % 2、判定辐射源的频点是否在侦察带宽内
                Lr = 32.4 + 20*log10(Target.Fre/1e6) + 20*log10(range_uav_radar);
                P_send = 30 + 10*log10(Target.Pow);
                Lx = 0;
                P = P_send + Target.Gt - Lr + UAV.Gr + Lx;    % 信号到达无人机天线的功率大小
                if (range_uav_radar < Target.RS)    % 3、信号功率与无人机系统灵敏度比较，信号功率大，能收到信号
                    angle1 = abs(derec(UAV.position,Target.position)-UAV.turnderection);     %目标方向与转台夹角
                    if angle1 > 180
                        angle1 = abs(angle1 - 360);
                    end
                    angle2 = abs(derec(Target.position,UAV.position)-Target.derection);     %目标方向与转台夹角
                    if angle2 > 180
                        angle2 = abs(angle2 - 360);
                    end
                    if (angle1 < UAV.bean_wd) && (angle2 < Target.bean_wd)    % 4、在波束范围里，满足扇形条件
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




            