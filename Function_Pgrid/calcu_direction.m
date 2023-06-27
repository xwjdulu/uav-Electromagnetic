% 计算两个坐标之间的方向向量，normalization确定是否归一化
function [ direction ] = calcu_direction(pos1,pos2,normalization)
dim = length(pos1);
direction = zeros(dim,1);
for i = 1:dim 
    direction(i) = pos1(i) - pos2(i);
end
if normalization
    dis = sqrt(sum((pos1 - pos2).^2,2));
    for i = 1:dim 
        direction(i) = direction(i)/dis;
    end
end
end
