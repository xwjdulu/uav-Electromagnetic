%��ʼ����������б�ṹ��
function Run_Grid_set = Initalize_Run_Grid_set(UAV, Grid_set, k)
%�������꣬Ƶ����Ϣ��(1��Ϣ�أ�2���Ǵ�����3Ƶ�ʣ�
%----------------------------------------------------------------------------------------------------------
empty_Run_Grid_set = struct('position',[],'TotalPhe',0,'FrePheromone',[],'warning',0);
%����Ⱥ��Ĵ洢�ṹ
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