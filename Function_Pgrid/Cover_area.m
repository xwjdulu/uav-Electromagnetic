%×ªÌ¨¸²¸Ç×ª½Ç
function [wd1, wd2] = Cover_area(derection)

d1 = derection + 135;
d2 = derection - 135;
if d1 > 180
    d1 = d1 - 360;
elseif d1 < -180
    d1 = d1 + 360;
end
if d2 > 180
    d2 = d2 - 360;
elseif d2 < -180
    d2 = d2 + 360;
end
if d1 * d2 > 0
    if d1 > d2
        wd1 = d1;
        wd2 = d2;
    else
        wd1 = d2;
        wd2 = d1;
    end
else
    if d1 > d2
        wd1 = d2;
        wd2 = d1;
    else
        wd1 = d1;
        wd2 = d2;
    end
end