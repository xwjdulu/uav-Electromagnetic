
%��ȡ��С�������Ԫ�ص�ԭʼ����
function [v,i] = Matrixmin(M)
    
    [j,~,~] = find(M~=0);
    v = min(M(j));
    [i,~] = find(M == v);
