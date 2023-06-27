% ����������ά����֮��ļнǣ����left_or_rightΪfalse�������ֵ��ԶΪ�������Ϊtrue��������������vector2���vector1������
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