% ����vector2��vector1���ұ���Ϊ��1���������Ϊ��1
function [ left_or_right] = calcu_left_or_right(vector1, vector2)
left_or_right = -vector2(1) * (vector1(2) - vector2(2)) + vector2(2) * (vector1(1) - vector2(1));
if left_or_right >=0
    left_or_right = -1;
else
    left_or_right = 1;
end
end