function [uuav] = disturbradio(target,uav,uavdisturbradio,num)
    uuav = uav;       %j代表无人机序号，i代表目标序号
    for j = 1:1:num
        if uavdisturbradio(j) ~= 0
            i = uavdisturbradio(j);
            uuav(j).vp_position =  target(i).position;
        end
    end
end

