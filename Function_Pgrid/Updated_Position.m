%求UAV更新位置
function UAV = Updated_Position(UAV, u, UAVnum, Run_Grid_set, k, Para, step, t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 划分区域选择全局适应度高的点运动
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bestFitness = [];
% max = 0;
% for i = 1:k
%     if Run_Grid_set(i).TotalPhe > max
%         max = Run_Grid_set(i).TotalPhe;
%     end
% end
% bestFitnessValue = [];
% for i = 1:k
%     if abs(Run_Grid_set(i).TotalPhe - max) < 0.01
%         bestFitness = [bestFitness;Run_Grid_set(i).position];
%         bestFitnessValue = [bestFitnessValue;Run_Grid_set(i).TotalPhe];
%     end
% end
% 
% i = 1;
% for j = 1:UAVnum
%     X(i) = UAV(j).position(1,1);
%     Y(i) = UAV(j).position(1,2);
%     i = i + 1;
% end
% v = [0 0 Para.MapL Para.MapW;0 Para.MapL Para.MapW 0]';
% [Ver,C,XY] = VoronoiLimit(X,Y,'bs_ext',v,'figure','on');   %输入UAV位置划分Voronoi区域
% hold on;
% 
% %求Voronoi图区域内距离最近的优秀适应度坐标作为运动方向
% [rows,cols] = size(bestFitness);
% V = Ver(C {jj},:);
% minLength = (2 * Para.MapL + 2 * Para.MapW)/2;
% %     manLength = 0;
% minPosition = UAV(jj).position;
% for  j = 1 : rows
%     [in,on] = inpolygon(bestFitness(j,1),bestFitness(j,2),V(:,1),V(:,2));
%     angle = abs(derec(UAV(jj).position,bestFitness(j,:))-UAV(jj).derection);
%     if angle > 180
%        angle = abs(angle - 360);
%     end
%     angle = pi*angle/180;
% %         if norm(bestFitness(j,:) - UAV(jj).position) + 10 * angle * UAV(jj).turnR < minLength && in == 1 && on == 0 && (norm(bestFitness(j,:) - UAV(jj).position)) ~= 0
%     if norm(bestFitness(j,:) - UAV(jj).position) < minLength && in == 1 && on == 0 && (norm(bestFitness(j,:) - UAV(jj).position)) ~= 0
% %             if norm(bestFitness(j,:) - UAV(jj).position) + 10 * angle * UAV(jj).turnR > manLength && in == 1 && on == 0 && (norm(bestFitness(j,:) - UAV(jj).position)) ~= 0
%         minLength = norm(bestFitness(j,:) - UAV(jj).position);
%         minPosition = bestFitness(j,:);
%     end
% end
% if minPosition - UAV(jj).position ~= 0
%     vector = minPosition - UAV(jj).position;
% else
%     vector = [rand,rand];
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 划分区域选择区域适应度高的点运动
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if UAVnum > 1
    i = 1;
    for j = 1:UAVnum
        X(i) = UAV(j).position(1,1)+unifrnd(0,0.001);
        if X(i) > Para.MapL
            X(i) = Para.MapL-unifrnd(0,0.01);
        end
        if X(i) < 0
            X(i) = 0+unifrnd(0,0.01);
        end
        Y(i) = UAV(j).position(1,2)+unifrnd(0,0.001);
        if Y(i) > Para.MapW
            Y(i) = Para.MapW-unifrnd(0,0.01);
        end
        if Y(i) < 0
            Y(i) = 0+unifrnd(0,0.01);
        end
        i = i + 1;
    end
    v = [0 0 Para.MapL Para.MapL;0 Para.MapW Para.MapW 0]';
    [Ver,C,XY] = VoronoiLimit(X,Y,'bs_ext',v,'figure','off');   %输入UAV位置划分Voronoi区域
    hold on;

    %求Voronoi图区域内距离最近的优秀适应度坐标作为运动方向
    xy = [X',Y'];
    u1 = find( XY(:,1) == xy(u,1));
    u2 = find( XY(:,2) == xy(u,2));
    u0 = Takerep([u1;u2]);
    V = Ver(C {u0},:);
else
    V = [0 0 Para.MapL Para.MapL;0 Para.MapW Para.MapW 0]';
end
bestFitness = [];
max = 0;
for i = 1:k
    [in,on] = inpolygon(Run_Grid_set(i).position(:,1),Run_Grid_set(i).position(:,2),V(:,1),V(:,2));
    if in == 1 && on == 0
        if Run_Grid_set(i).TotalPhe > max
            max = Run_Grid_set(i).TotalPhe;
        end
    end
end
bestFitnessValue = [];
for i = 1:k
    [in,on] = inpolygon(Run_Grid_set(i).position(:,1),Run_Grid_set(i).position(:,2),V(:,1),V(:,2));
    if in == 1 && on == 0
        if abs(Run_Grid_set(i).TotalPhe - max) < 0.01
            bestFitness = [bestFitness;Run_Grid_set(i).position];
            bestFitnessValue = [bestFitnessValue;Run_Grid_set(i).TotalPhe];
        end
    end
end
[rows,cols] = size(bestFitness);
minLength = (2 * Para.MapL + 2 * Para.MapW)/2;
minPosition = UAV(u).position;
for  j = 1 : rows
    angle = abs(derec(UAV(u).position,bestFitness(j,:))-UAV(u).derection);
    if angle > 180
       angle = abs(angle - 360);
    end
    angle = pi*angle/180;
    if norm(bestFitness(j,:) - UAV(u).position) + 0.1 * angle * UAV(u).turnR < minLength && (norm(bestFitness(j,:) - UAV(u).position)) ~= 0
%     if norm(bestFitness(j,:) - UAV(jj).position) < minLength && (norm(bestFitness(j,:) - UAV(jj).position)) ~= 0
        minLength = norm(bestFitness(j,:) - UAV(u).position);
        minPosition = bestFitness(j,:);
    end
end
if minPosition - UAV(u).position ~= 0
    vector1 = minPosition - UAV(u).position;
else
    vector1 = [0,0];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 选择局部多个运动方向适应度高的点运动
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tempmax = 0;
% vp_angle = [0,45,-45,90,-90,135,-135,-180];
vp_angle = [0,45,-45,90,-90];
di = 1;
for i = 1:1:size(vp_angle,2)
    vp_derection = UAV(u).derection + vp_angle(i);
    if vp_derection > 180
        vp_derection = vp_derection - 360;
    elseif vp_derection < -180
        vp_derection = vp_derection + 360;
    end
    x1 = UAV(u).position(1,1) + step * UAV(u).Vmax * cos(vp_derection * pi / 180);
    y1 = UAV(u).position(1,2) + step * UAV(u).Vmax * sin(vp_derection * pi / 180);
    DTPsum = 0;
    for g = 1:1:k
        if sqrt(sum((Run_Grid_set(g).position - [x1,y1]).^2,2)) < UAV(u).R - (2 * (Para.Unit/2) / 3) + 2 * step * UAV(u).Vmax
            angle = abs(derec([x1,y1],Run_Grid_set(g).position) - vp_derection);
            if angle > 180
                angle = abs(angle - 360);
            end
            if (angle < 110)
                DTPsum = DTPsum + Run_Grid_set(g).TotalPhe;
            end
        end
    end
    if DTPsum > tempmax
        tempmax = DTPsum;
        di = i;
    end
end
uderection = UAV(u).derection + vp_angle(di);
if uderection > 180
    uderection = uderection - 360;
elseif uderection < -180
    uderection = uderection + 360;
end
xi = UAV(u).position(1,1) + step * UAV(u).Vmax * cos(uderection * pi / 180);
yi = UAV(u).position(1,2) + step * UAV(u).Vmax * sin(uderection * pi / 180);
vector2 = [xi,yi] - UAV(u).position;
vector = vector1 + 8 * vector2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 不划分区域选择适应度高的点运动
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bestFitness = [];
% max = 0;
% for i = 1:k
%     if Run_Grid_set(i).TotalPhe > max 
%         max = Run_Grid_set(i).TotalPhe;
%     end
% end
% bestFitnessValue = [];
% for i = 1:k
%     if abs(Run_Grid_set(i).TotalPhe - max) < 0.002
%         bestFitness = [bestFitness;Run_Grid_set(i).position];
%         bestFitnessValue = [bestFitnessValue;Run_Grid_set(i).TotalPhe];
%     end
% end
% 
% %求区域内距离最近的优秀适应度坐标作为运动方向
% [rows,cols] = size(bestFitness);
% for jj = 1:UAVnum
%     minLength = (2 * Para.MapL + 2 * Para.MapW)/2;
% %     manLength = 0;
%     minPosition = UAV(jj).position;
%     for  j = 1 : rows
%         angle = abs(derec(UAV(jj).position,bestFitness(j,:))-UAV(jj).derection);
%         if angle > 180
%            angle = abs(angle - 360);
%         end
%         angle = pi*angle/180;
%         if jj == 1
%             if norm(bestFitness(j,:) - UAV(jj).position) + 10 * angle * UAV(jj).turnR < minLength && (norm(bestFitness(j,:) - UAV(jj).position)) ~= 0
% %             if norm(bestFitness(j,:) - UAV(jj).position) + 10 * angle * UAV(jj).turnR > manLength && in == 1 && on == 0 && (norm(bestFitness(j,:) - UAV(jj).position)) ~= 0
%                 minLength = norm(bestFitness(j,:) - UAV(jj).position);
%                 minPosition = bestFitness(j,:);
%             end
%         else
%             for i = 1:jj
%                 if norm(bestFitness(j,:) - UAV(jj).position) + 10 * angle * UAV(jj).turnR < minLength && (norm(bestFitness(j,:) - UAV(jj).position)) ~= 0
% %                 if norm(bestFitness(j,:) - UAV(jj).position) + 10 * angle * UAV(jj).turnR > manLength && in == 1 && on == 0 && (norm(bestFitness(j,:) - UAV(jj).position)) ~= 0
%                     minLength = norm(bestFitness(j,:) - UAV(jj).position);
%                     minPosition = bestFitness(j,:);
%                 end
%             end
%         end
%     end
%     if minPosition - UAV(jj).position ~= 0
%         vector = minPosition - UAV(jj).position;
%     else
%         vector = [rand,rand];
%     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 区域划分质心方向运动
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% i = 1;
% for j = 1:UAVnum
%     X(i) = UAV(j).position(1,1);
%     Y(i) = UAV(j).position(1,2);
%     i = i + 1;
% end
% v = [1 1 Para.MapL Para.MapW;1 Para.MapL Para.MapW 1]';
% [Ver,C,XY] = VoronoiLimit(X,Y,'bs_ext',v,'figure','off');   %输入UAV位置划分Voronoi区域
% 
% Area=zeros(1,UAVnum);
% for j=1:UAVnum
%     V= Ver(C {j},:); %这里的V就是第j个多边形的顶点序列 
%     [k,Area(j)] = convhull(V(:,1),V(:,2));%计算第j个多边形的面积Area（j）
%     xleft = floor(min(V(:,1)));
%     xright = ceil(max(V(:,1)));
%     yleft = floor(min(V(:,2)));
%     yright = ceil(max(V(:,2)));
%     sumX = 0;
%     sumY = 0;
%     sumXarea = 0;
%     for ArowsI = xleft : xright
%         for AcolsJ  = yleft : yright
%             [in,on] = inpolygon(ArowsI,AcolsJ,V(:,1),V(:,2));
% %             if in == 1 && on == 0
%             if in == 1 && A(ArowsI,AcolsJ) <= 0.99
%                 densityCoefficient = exp(-2 * log(1 / A(ArowsI,AcolsJ) - 1 )) ;%密度转换公式，降低了低概率的权重，加大了高概率的权重
%                 if isinf(densityCoefficient)
%                     densityCoefficient = 1;
%                 end
%                 sumX = sumX + ArowsI * densityCoefficient;
%                 sumY = sumY + AcolsJ * densityCoefficient;
%                 sumXarea = sumXarea + densityCoefficient;
%                 if isnan(sumX) || isnan(sumXarea) || isnan(sumY) || isinf(sumX) || isinf(sumXarea) || isinf(sumY)
%                     error('NAN 或者 inf');
%                 end
%             end
%         end
%     end
%     vector = [sumX / sumXarea , sumY / sumXarea];
%     vector = vector - UAV(j).position;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 运动约束
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%无人机间斥力
force_between_uavs = zeros(UAVnum,2);
for j = 1:UAVnum
    if u ~= j
        fdirection = calcu_direction(UAV(j).position, UAV(u).position,1);
        dis = norm(UAV(j).position - UAV(u).position);
        if dis <= Para.uav_col
            f = 0.8 * (dis - Para.uav_col) * exp(0.8 * abs(dis - Para.uav_col));
        else
            f = 0;
        end
        force_between_uavs(u,1) = force_between_uavs(u,1) + fdirection(1) * f;
        force_between_uavs(u,2) = force_between_uavs(u,2) + fdirection(2) * f;
    end
end
vector = [force_between_uavs(u,1) + UAV(u).velocity(1) + vector(1), force_between_uavs(u,2) + UAV(u).velocity(2) + vector(2)];
%转弯角限制
turnA = 180 / (pi * UAV(u).turnR / (step * UAV(u).Vmin));
if calcu_angle(UAV(u).velocity,vector,0) > turnA
    alpha = turnA * calcu_left_or_right(UAV(u).velocity, vector);
    vector = calcu_turn_angle(UAV(u).velocity, alpha, 0);
end
%更新位置
len = norm(vector);
if len == 0
    velocity = UAV(u).velocity;
elseif len > step * UAV(u).Vmax
    velocity = step * UAV(u).Vmax * vector / len;
elseif len < step * UAV(u).Vmin
    velocity = step * UAV(u).Vmin * vector / len;
else
    velocity = vector;
end
UAV(u).vp_position = UAV(u).position + velocity;
if UAV(u).vp_position(1) > Para.MapL
    UAV(u).vp_position(1) = Para.MapL;
end
if UAV(u).vp_position(2) > Para.MapW
    UAV(u).vp_position(2) = Para.MapW;
end
if UAV(u).vp_position(1) < 0
    UAV(u).vp_position(1) = 0;
end
if UAV(u).vp_position(2) < 0
   UAV(u).vp_position(2) = 0;
end
UAV(u).steptime = t-1;%记录当前时刻位置
