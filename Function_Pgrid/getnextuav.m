function [a,b,c] = getnextuav(target,i,uavnum,uav)
    a = 0;
    b = 0;
    c = 0;
    min1 = 100000;
    min2 = 200000;
    min3 = 300000;
    x = target(i).position(1);
    y = target(i).position(2);
    for k = 1:1:uavnum
            xx = uav(k).position(1);
            yy = uav(k).position(2);
            d = sqrt((x-xx) * (x-xx) + (y - yy)*(y-yy));
            if d<min1
                min3 = min2;
                min2 = min1;
                min1 = d;
                c = b;
                b = a;
                a = k;
            elseif d<min2
                min3 = min2;
                min2 = d;
                c = b;
                b = k;
            elseif d<min3
                min3 = d;
                c = k;
            end
    end
end

