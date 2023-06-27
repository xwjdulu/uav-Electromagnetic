%%��ƽ̨/Ŀ���˶��켣
function [UAV, Target, route, Troute] = DrawTrack(t, UAVnum, Targetnum, UAV, Target, UAVposition, Targetposition, route, Troute, Para)
%�洢�˶��켣
%��λ�������ų�t��20�е���ʽ��ÿ2�д���ƽ̨λ�ñ仯
route(t,:) = reshape(UAVposition',[],1);
Troute(t,:) = reshape(Targetposition',[],1);
% droute = smooth(route);
% dTroute = smooth(Troute);

%�����˻��˶��켣
for j = 1:1:UAVnum
%     plot(route(1:end,2*j-1),route(1:end,2*j),'-.','color',UAV(j).color,'linewidth',0.5);hold on;
    plot(route(1:end,2*j-1),route(1:end,2*j),'color',UAV(j).color,'linewidth',0.5);hold on;
    %����ÿ��Ĺ켣��
    plot(route(t,2*j-1),route(t,2*j),'color',UAV(j).color,'Marker','o');hold on;
    %��������λ��
    DrawSector(route(t,2*j-1),route(t,2*j),UAV(j).turnderection,UAV(j).bean_wd,UAV(j).R,100,UAV(j).Fre(UAV(j).f0),0);hold on;
%     UAV(j).f0 = UAV(j).f0 + 1;             %Ƶ�ʹ���ɨ��
%     if mod(UAV(j).f0,size(UAV(j).Fre,2)+1)==0
%         UAV(j).f0 = 1;
%     end
end

%��Ŀ���˶��켣
for j = 1:1:Targetnum
    plot(Troute(1:end,2*j-1),Troute(1:end,2*j),'k:','linewidth',1);hold on;
    if Target(j).type == 0
        plot(Troute(t,2*j-1),Troute(t,2*j),'*','color',Target(j).color,'markersize',5);hold on;
    else
        plot(Troute(t,2*j-1),Troute(t,2*j),'*','color',Target(j).color,'markersize',10);hold on;
    end
end

xlabel('����/km');
ylabel('�����/km');
title(['patrol, Time is ',num2str(t),' s']);
axis([0,Para.MapL,0,Para.MapW]);
end