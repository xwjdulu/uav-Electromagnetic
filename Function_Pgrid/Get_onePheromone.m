%��Ƶ����Ϣ�أ�����Ƶ���ڵ�ͼ�ϵ���Ϣ��ֵ��
function [oneFrePheromonemap] = Get_onePheromone(UAVFre, Grid_set, Grid_set_FrePheromone, Fre, one)   %X���С�Y����
fre0 = UAVFre;
[~,k] = find(fre0 == Fre);
x = unique(Grid_set(:,1));
y = unique(Grid_set(:,2));
for i = 1:length(x)
    for j = 1:length(y)
        h1 = find(Grid_set(:,1) == x(i));
        h2 = find(Grid_set(:,2) == y(j));
        h = Takerep([h1;h2]);
        if one
            oneFrePheromonemap(i,j) = 1-Grid_set_FrePheromone(h,k);
        else
            oneFrePheromonemap(i,j) = 1-mean(Grid_set_FrePheromone(h,:));
        end
    end
end

