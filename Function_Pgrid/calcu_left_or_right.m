% 向量vector2在vector1的右边则为正1，在左边则为负1
function [ left_or_right] = calcu_left_or_right(vector1, vector2)
left_or_right = -vector2(1) * (vector1(2) - vector2(2)) + vector2(2) * (vector1(1) - vector2(1));
if left_or_right >=0
    left_or_right = -1;
else
    left_or_right = 1;
end
end