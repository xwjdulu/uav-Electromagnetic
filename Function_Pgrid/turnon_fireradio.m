function [ttarget]=turnon_fireradio(i,target,p)   %i号搜索雷达开机10km内火控雷达

if  12<i && i<17
    for j = 17:1:24
        x = target(i).position(1);
        y = target(i).position(2);
        xx = target(j).position(1);
        yy = target(j).position(2);
        d = sqrt((x-xx)*(x-xx)+(y-yy)*(y-yy));
        if randi([0,99])<p && d<10
            target(j).ison = 1;
            target(j).Vmax = 0;
         end
    end
end
ttarget = target;
end

