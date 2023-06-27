
%提取最小非零矩阵元素的原始行数
function [v,i] = Matrixmin(M)
    
    [j,~,~] = find(M~=0);
    v = min(M(j));
    [i,~] = find(M == v);
