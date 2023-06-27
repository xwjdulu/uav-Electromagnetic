%%画平台/目标运动轨迹
function [UAV, Target, route, Troute] = DrawTrack(t, UAVnum, Targetnum, UAV, Target, UAVposition, Targetposition, route, Troute, Para)
%存储运动轨迹
%将位置坐标排成t行20列的形式，每2列代表平台位置变化
route(t,:) = reshape(UAVposition',[],1);
Troute(t,:) = reshape(Targetposition',[],1);
% droute = smooth(route);
% dTroute = smooth(Troute);

%画无人机运动轨迹
for j = 1:1:UAVnum
%     plot(route(1:end,2*j-1),route(1:end,2*j),'-.','color',UAV(j).color,'linewidth',0.5);hold on;
    plot(route(1:end,2*j-1),route(1:end,2*j),'color',UAV(j).color,'linewidth',0.5);hold on;
    %画出每秒的轨迹点
    plot(route(t,2*j-1),route(t,2*j),'color',UAV(j).color,'Marker','o');hold on;
    %画出最终位置
    DrawSector(route(t,2*j-1),route(t,2*j),UAV(j).turnderection,UAV(j).bean_wd,UAV(j).R,100,UAV(j).Fre(UAV(j).f0),0);hold on;
%     UAV(j).f0 = UAV(j).f0 + 1;             %频率规律扫描
%     if mod(UAV(j).f0,size(UAV(j).Fre,2)+1)==0
%         UAV(j).f0 = 1;
%     end
end

%画目标运动轨迹
for j = 1:1:Targetnum
    plot(Troute(1:end,2*j-1),Troute(1:end,2*j),'k:','linewidth',1);hold on;
    if Target(j).type == 0
        plot(Troute(t,2*j-1),Troute(t,2*j),'*','color',Target(j).color,'markersize',5);hold on;
    else
        plot(Troute(t,2*j-1),Troute(t,2*j),'*','color',Target(j).color,'markersize',10);hold on;
    end
end

xlabel('区域长/km');
ylabel('区域宽/km');
title(['patrol, Time is ',num2str(t),' s']);
axis([0,Para.MapL,0,Para.MapW]);
end