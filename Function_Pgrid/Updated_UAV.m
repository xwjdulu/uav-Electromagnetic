%%更新每个平台的参数
function [UAV, UAVposition, Run_Grid_set, Juli] = Updated_UAV(t, UAVnum, UAV, Run_Grid_set, turn_angle, k, Juli, Para) 

step = 50;%更新位置秒数
for i = 1:1:UAVnum
    if isempty(UAV(i).vp_position)
        UAV = Updated_Position(UAV, i, UAVnum, Run_Grid_set, k, Para, step, t);
%         UAV(i).vp_position = [randi(Para.MapL),randi(Para.MapW)];
%         UAV(i).steptime = t-1;
    end
    vector = UAV(i).vp_position - UAV(i).position;
    inipositon = UAV(i).position;
    %无人机间斥力
    force_between_uavs = zeros(UAVnum,2);
    for j = 1:UAVnum
        if i ~= j
            fdirection = calcu_direction(UAV(j).position, UAV(i).position,1);
            dis = norm( UAV(j).position - UAV(i).position);
            if dis <= Para.uav_col
                f = 0.8 * (dis - Para.uav_col) * exp(0.8 * abs(dis - Para.uav_col));
            else
                f = 0;
            end
            force_between_uavs(i,1) = force_between_uavs(i,1) + fdirection(1) * f;
            force_between_uavs(i,2) = force_between_uavs(i,2) + fdirection(2) * f;
        end
    end
    vector = [force_between_uavs(i,1) + UAV(i).velocity(1) + vector(1), force_between_uavs(i,2) + UAV(i).velocity(2) + vector(2)];
    %转弯角限制
    if calcu_angle(UAV(i).velocity,vector,0) > UAV(i).turnA
        alpha = UAV(i).turnA * calcu_left_or_right(UAV(i).velocity, vector);
        vector = calcu_turn_angle(UAV(i).velocity, alpha, 0);
    end
    %速度限制
    len = norm(vector);
    if len == 0 
        UAV(i).velocity = UAV(i).velocity;
    elseif len > UAV(i).Vmax
        UAV(i).velocity = UAV(i).Vmax * vector / len;
    elseif len < UAV(i).Vmin
        UAV(i).velocity = UAV(i).Vmin * vector / len;
    else
        UAV(i).velocity = vector;
    end
    %更新位置
    UAV(i).position = UAV(i).position + UAV(i).velocity;
%     if UAV(i).position(1) > Para.MapL
%         UAV(i).position(1) = Para.MapL;
%     end
%     if UAV(i).position(2) > Para.MapW
%         UAV(i).position(2) = Para.MapW;
%     end
%     if UAV(i).position(1) < 0
%         UAV(i).position(1) = 0;
%     end
%     if UAV(i).position(2) < 0
%        UAV(i).position(2) = 0;
%     end
    UAVposition(i,:) = UAV(i).position;
    UAV(i).derection = derec(inipositon,UAV(i).position);
    if t - UAV(i).steptime == step
        UAV(i).vp_position = [];
    end
    %转台转动
    UAV(i) = TurntableControl(UAV(i), Run_Grid_set, k, turn_angle, Para);
    %更新覆盖网格信息素
    Run_Grid_set = Updated_Pheromone_coverage(UAV(i), Run_Grid_set, k, Para);

%     %通信
%     for j = 1:1:UAVnum
%         if i ~= j
%             if sqrt(sum((UAV(i).position - UAV(j).position).^2,2)) < UAV(i).Commdist
%                 line([UAV(i).position(1),UAV(j).position(1)],[UAV(i).position(2),UAV(j).position(2)]);
%             end
%         end
%     end
end
end