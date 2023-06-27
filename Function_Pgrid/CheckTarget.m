%检测目标是否存在
function [get_target] = CheckTarget(get_target, UAV, j, t)
T = t;
if get_target
    if UAV.PDW.Fre == 0 && UAV.PDW.Width == 0 && UAV.PDW.TOA == 0 && UAV.PDW.direction == 0 && UAV.PDW.Gt == 0 && UAV.PDW.Pow == 0
%         disp(['UAV_',num2str(j),'搜索',num2str(T),'秒后发现疑似威胁目标']); 
%         disp(['检测无目标出现，继续搜索']);
        get_target = 0;
    end
end