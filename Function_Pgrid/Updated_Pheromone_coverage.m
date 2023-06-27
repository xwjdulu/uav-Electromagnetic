%%覆盖网格信息素更新
function [Run_Grid_set] = Updated_Pheromone_coverage(UAV, Run_Grid_set, k, Para)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%覆盖网格后信息素更新
Pp = 0.992; %探测概率
for q = 1:1:k
    if sqrt(sum((Run_Grid_set(q).position - UAV.position).^2,2)) < UAV.R - (2 * (Para.Unit/2) / 3)
        angle = abs(derec(UAV.position,Run_Grid_set(q).position)-UAV.turnderection);
        if angle > 180
            angle = abs(angle - 360);
        end
        if (angle < UAV.bean_wd)
            [f0,~] = find(Run_Grid_set(q).FrePheromone(:,3) == UAV.Fre(UAV.f0));
            Run_Grid_set(q).FrePheromone(f0,2) = Run_Grid_set(q).FrePheromone(f0,2) + 0.01;
            d = norm(UAV.position - Run_Grid_set(q).position);
            Run_Grid_set(q).FrePheromone(f0,1) = (d / UAV.R) * (2-Pp) / Run_Grid_set(q).FrePheromone(f0,2) * Run_Grid_set(q).FrePheromone(f0,1);
            if Run_Grid_set(q).FrePheromone(f0,1) > 1
                Run_Grid_set(q).FrePheromone(f0,1) = 1;
            end
        end
        Run_Grid_set(q).TotalPhe = mean(Run_Grid_set(q).FrePheromone(:,1));
    end
end