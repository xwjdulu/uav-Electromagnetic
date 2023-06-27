% 计算两个二维向量之间的夹角，如果left_or_right为false，则计算值永远为正，如果为true，则有正负，如vector2相对vector1左负右正
function [ angle] = calcu_angle(vector1, vector2, left_or_right)
edge3 = sqrt(sum((vector1 - vector2).^2,2));
edge1 = sqrt(power(vector1(1), 2) + power(vector1(2), 2));
edge2 = sqrt(power(vector2(1), 2) + power(vector2(2), 2));
value = (edge1 * edge1 + edge2 * edge2 - edge3 * edge3) / 2 / edge1 / edge2;
if value > 1
    value = 1;
elseif value < -1
    value = -1;
end
angle = rad2deg(acos(value));
if left_or_right
    angle = angle * calcu_left_or_right(vector1, vector2);
end
end