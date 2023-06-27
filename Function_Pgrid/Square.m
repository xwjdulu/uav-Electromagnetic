
function [V,k] = SquareDraw(R_s,Width,Height)
% (sqrt(2)/2)
R_S = 2 * R_s;
N_l = round(Width/R_S);   %round��������Ϊ��������
N_w = round(Height/R_S);
N_sum = N_l*N_w;  %�����й�ʽ1

V = zeros(N_sum,2);  
k = 1;
for i = 0:1:N_l-1
    for j = 0:1:N_w-1
        V(k,:) = [R_S/2+i*R_S,R_S/2+j*R_S]; %�������⺽�㣬�����й�ʽ2
        k = k + 1;
    end 
end
k = k - 1;