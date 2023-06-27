%初始化网格参数列表结构体
function Run_Grid_set = Initalize_Run_Grid_set(UAV, Grid_set, k)
%网格坐标，频率信息素(1信息素；2覆盖次数；3频率）
%----------------------------------------------------------------------------------------------------------
empty_Run_Grid_set = struct('position',[],'TotalPhe',0,'FrePheromone',[],'warning',0);
%建立群体的存储结构
Run_Grid_set = repmat(empty_Run_Grid_set,k,1);
for i = 1:1:k
    Run_Grid_set(i).position = Grid_set(i,:);
    Run_Grid_set(i).FrePheromone = ones(size(UAV(1).Fre,2),3);
    for j = 1:1:size(UAV(1).Fre,2)
        Run_Grid_set(i).FrePheromone(j,3) = UAV(1).Frequency(j);
    end
    Run_Grid_set(i).TotalPhe = mean(Run_Grid_set(i).FrePheromone(:,1));
    Run_Grid_set(i).warning = 0;
end