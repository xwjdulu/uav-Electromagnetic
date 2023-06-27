%确定转台转向及变频
function UAV = TurntableControl(UAV, Run_Grid_set, k, turn_angle, Para)  
Pp = 0.992; %探测概率
Pcrmax = 0;
for i = 1:1:size(turn_angle,2)
    for f0 = 1:1:size(UAV.Fre,2)
        VPcrsum = 0;
        for g = 1:1:k
            f = find(Run_Grid_set(g).FrePheromone(:,3) == UAV.Fre(f0));
            if norm(UAV.position - Run_Grid_set(g).position) < UAV.R - (2 * (Para.Unit/2) / 3)
                Turnderection = UAV.derection + turn_angle(i);
                if Turnderection > 180
                    Turnderection = Turnderection - 360;
                elseif Turnderection < -180
                    Turnderection = Turnderection + 360;
                end
                angle = abs(derec(UAV.position,Run_Grid_set(g).position) - Turnderection);
                if angle > 180
                    angle = abs(angle - 360);
                end
                if (angle < UAV.bean_wd)
                    d = norm(UAV.position - Run_Grid_set(g).position);
                    Pf0 = (d / Para.MapL) * (2-Pp) / (Run_Grid_set(g).FrePheromone(f,2)+0.01) * Run_Grid_set(g).FrePheromone(f,1);
                    if Pf0 > 1
                        Pf0 = 1;
                    end
                    VPcrsum = VPcrsum + abs(Pf0 - Run_Grid_set(g).FrePheromone(f,1));
                end
            end
        end
        if VPcrsum >= Pcrmax
            Pcrmax = VPcrsum;
            fj = f;
            Vi = i;
        end
    end
end
[UAV.f0,~] = find(UAV.Fre(:) == UAV.Frequency(fj));
UAV.turnderection = UAV.derection;
if UAV.turnderection > 180
    UAV.turnderection = UAV.turnderection - 360;
elseif UAV.turnderection < -180 
    UAV.turnderection = UAV.turnderection + 360;
end
%扫频
% UAV.f0 = UAV.f0 + 1;
% angle = UAV.turnderection - UAV.derection;
% if angle > 180
%     angle = angle - 360;
% elseif angle < -180 
%     angle = angle + 360;
% end
% [~,Vi] = min(abs(turn_angle - angle));
% UAV.turnderection = UAV.derection + turn_angle(Vi);
% if UAV.turnderection > 180
%     UAV.turnderection = UAV.turnderection - 360;
% elseif UAV.turnderection < -180 
%     UAV.turnderection = UAV.turnderection + 360;
% end
% if UAV.f0 > size(UAV.Fre,2)
%     UAV.f0 = 1;
%     if Vi+1 > size(turn_angle,2)
%         Vi = 0;
%     end
%     UAV.turnderection = UAV.derection + turn_angle(Vi+1);
%     if UAV.turnderection > 180
%         UAV.turnderection = UAV.turnderection - 360;
%     elseif UAV.turnderection < -180 
%         UAV.turnderection = UAV.turnderection + 360;
%     end
% end
%随机
% UAV.f0 = randi((size(UAV.Fre,2)));
% UAV.turnderection = UAV.derection + turn_angle(randi(size(turn_angle,2)));
%     if UAV.turnderection > 180
%         UAV.turnderection = UAV.turnderection - 360;
%     elseif UAV.turnderection < -180 
%         UAV.turnderection = UAV.turnderection + 360;
%     end
%确定转向
% if isempty(UAV.vp_turnderection)
%     Juli = [];
%     for p = 1:1:k
%         if sqrt(sum((Run_Grid_set(p).position - UAV.position).^2,2)) < UAV.R
%             if Run_Grid_set(p).TotalPhe > 0.1 
%                 Juli(p,1) = sqrt(sum((Run_Grid_set(p).position - UAV.position).^2,2));
%                 Angle(p,1) = derec(UAV.position,Run_Grid_set(p).position)-UAV.derection;
%                 if Angle(p,1) > 180
%                     Angle(p,1) = Angle(p,1) - 360;
%                 elseif Angle(p,1) < -180
%                     Angle(p,1) = Angle(p,1) + 360;
%                 end
%             end
%         end
%     end
%     if ~isempty(Juli)
%         if UAV.turnswitch
%             [distmin,dd] = Matrixmin(Juli);
%             if size(dd,1) > 1
%                 dd = dd(1,:);
%             end
% %                 Run_Grid_set(dd,4) = 0;
% %                 angle = min(abs(angle(:)));
%             UAV.vp_turnderection = Run_Grid_set(dd).position;
%             [~,UAV.u0] = min(abs(turn_angle(:)-Angle(dd,1)));    %【选择距离最近？】
% %             [~,UAV.f0] = min(Run_Grid_set(dd).FrePheromone(:,1));     %【跳变最大】
%             UAV.f0 = randi((size(UAV.Fre,2)));
%         end
%     end
% end
% 
% %转台转动
% if ~isempty(Juli) && UAV.turnswitch
%     wg = 8 * ( UAV.R / Para.Unit )^2;
%     if (size(Juli(Juli~=0),1) < wg) || get_target    %小场景20，大场景150
%         if UAV.turnswitch
%             if UAV.u < UAV.u0
%                 UAV.u = UAV.u + 1;
%             elseif UAV.u > UAV.u0
%                 UAV.u = UAV.u - 1;
%             else
% %                     UAV(i).turnswitch = 0;
%             end
%             UAV.turnderection = UAV.derection + turn_angle(UAV.u);
%             if UAV.turnderection > 180
%                 UAV.turnderection = UAV.turnderection - 360;
%             elseif UAV.turnderection < -180 
%                 UAV.turnderection = UAV.turnderection + 360;
%             end
%         end
%         if ~isempty(UAV.vp_turnderection) && ~get_target
%             [r1,~,~] = find(Grid_set == UAV.vp_turnderection);
%             R = Takerep(r1);
%             if Run_Grid_set(R).FrePheromone(UAV.f0) > 0.6
%                 UAV.vp_turnderection = [];
%             end
%             angle = abs(derec(UAV.position,Run_Grid_set(R).position)-UAV.derection);
%             if angle > 180
%                 angle = abs(angle - 360);
%             end
%             [wd1, wd2] = Cover_area(UAV.derection);
%             if(angle > wd2) || (angle < wd1)
%                 UAV.vp_turnderection = [];
%             end
%         end
%     else
%         if UAV.turnswitch
%             if UAV.u < 61
%                 UAV.u = UAV.u + 1;
%                 UAV.turnderection = UAV.derection + turn_angle(UAV.u);
%             elseif UAV.u > 61
%                 UAV.u = UAV.u - 1;
%                 UAV.turnderection = UAV.derection + turn_angle(UAV.u);
%             else
%                 UAV.turnderection = UAV.derection + turn_angle0(UAV.uq);
%                 UAV.uq = UAV.uq + 1;
%                 if mod(UAV.uq,size(turn_angle0,2)+1) == 0
%                     UAV.uq = 1;
%                 end
%             end
%             if UAV.turnderection > 180
%                 UAV.turnderection = UAV.turnderection - 360;
%             elseif UAV.turnderection < -180 
%                 UAV.turnderection = UAV.turnderection + 360;
%             end
%         end
%     end
% end
% end