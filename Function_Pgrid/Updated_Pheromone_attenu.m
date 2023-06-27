%%��Ϣ�ظ���˥��
function [Run_Grid_set] = Updated_Pheromone_attenu(Run_Grid_set, px, py, g, k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��Ϣ��˥��
for p = 1:1:k
    for f = 1:1:size(Run_Grid_set(1).FrePheromone,1)
        if Run_Grid_set(p).FrePheromone(f,1) ~= 1
            Run_Grid_set(p).FrePheromone(f,1) = Run_Grid_set(p).FrePheromone(f,1) + g;
            if Run_Grid_set(p).FrePheromone(f,1) >= 0.95
                Run_Grid_set(p).FrePheromone(f,1) = 0.95;
            end
        end
    end
    Run_Grid_set(p).TotalPhe = mean(Run_Grid_set(p).FrePheromone(:,1));
    plot(px+Run_Grid_set(p).position(1),py+Run_Grid_set(p).position(2),'k','linewidth',0.01); %��������
    %��ʾ��Ϣ��
    fill(px+Run_Grid_set(p).position(1),py+Run_Grid_set(p).position(2),[0.6902,0.87843,0.90196],'facealpha',Run_Grid_set(p).TotalPhe);
    hold on;
end
%��ʾ�����
% plot(Grid_set(:,1),Grid_set(:,2),'.','markersize',1);hold on; %�����������ĵ�
% hold on;
end