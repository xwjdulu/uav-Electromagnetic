%���Ŀ���Ƿ����
function [get_target] = CheckTarget(get_target, UAV, j, t)
T = t;
if get_target
    if UAV.PDW.Fre == 0 && UAV.PDW.Width == 0 && UAV.PDW.TOA == 0 && UAV.PDW.direction == 0 && UAV.PDW.Gt == 0 && UAV.PDW.Pow == 0
%         disp(['UAV_',num2str(j),'����',num2str(T),'�����������вĿ��']); 
%         disp(['�����Ŀ����֣���������']);
        get_target = 0;
    end
end