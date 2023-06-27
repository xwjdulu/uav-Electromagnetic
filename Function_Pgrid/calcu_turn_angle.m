% ���ذѶ�ά����angle˳ʱ��ת��turn_value�Ⱥ��������turn_value����Ϊ��������ʱ��ת��normalization�����Ƿ��һ�����
function [ direction ] = calcu_turn_angle(angle, turn_value, normalization)
x_ = angle(2) * sin(deg2rad(turn_value)) + angle(1) * cos(deg2rad(turn_value));
y_ = angle(2) * cos(deg2rad(turn_value)) - angle(1) * sin(deg2rad(turn_value));
direction = [x_, y_];
if normalization
    temp = sqrt(power(direction(1), 2) + power(direction(2), 2));
    direction = [direction(1) / temp, direction(2) / temp];
end
end