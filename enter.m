function[]=patrol_target_PheromoneFre2_0(M,Para)
UAVnum = Para.UAVnum;  %ƽ̨����
Targetnum = Para.Targetnum;   %Ŀ������

%���ָ��ʼ������
% F2_SuccN = 0;
% F1_SuccN = 0;
SuccN = 0;
FailN = 0;
MaxFtime = [];
Ftime = [];
Fnum = [];
averageFG = [];
tnum = 0;
Gra = 0;
TNUM = 3;  %�������
figure('Position',[100 100 1600 1600]);
%----------------------------------------------------------------------------- 
while(1)
%%��ʼ��ƽ̨/Ŀ������б�ṹ��
[UAV, turn_angle] = Initalize_UAV(Para, UAVnum);
Target = Initalize_Target(UAV, Para, Targetnum);

%���������������
[Grid_set,k,px,py] = Get_Grid_set(Para, M);

%%��ʼ����������б�ṹ��
Run_Grid_set = Initalize_Run_Grid_set(UAV, Grid_set, k);

%----------------------------------------------------------------------------- 
%��ʼ��������a
subplot(1,2,1);
set(gca, 'Units', 'normalized', 'Position', [0.085 0.105 0.395 0.795]);
F1 = 0;
F2 = 0;
F = 0;
w = 0;        %�ٶȹ���ϵ��
g = 0.003;    %˥����
% g = UAV(1).Vmin * Para.Unit / 0.5 * Para.MapL * Para.MapL;
route = [];
Troute = [];
t = 1;
a = 0;
Tend = 500;  %Ѳ��ʱ��  С����20���󳡾�3000
% Tend = 20;
% FG = zeros(time,1);
FG = [];
S = ones(UAVnum,1);
TT = randi([2,30]);   %Ŀ������
Signal = 1;
Comm = 0;
p0 = 0;
Juli = [];
e = 0;
e2 = 0;
e1 = 0;
get_target = zeros(Targetnum,UAVnum);
num = 0;  %�ҵ�Ŀ�����
repeat = 1;
for i = 1:Targetnum
    	discovertime(i) = Tend;
end
disturbtime = Tend;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ʵʱ��ʾ
while(1)  
    %��ʾ���񼰺��㣬��Ϣ��˥��
    [Run_Grid_set] = Updated_Pheromone_attenu(Run_Grid_set, px, py, g, k);
    %����ÿ��ƽ̨����
    [UAV, UAVposition, Run_Grid_set, Juli] = Updated_UAV(t, UAVnum, UAV, Run_Grid_set, turn_angle, k, Juli, Para);
    %����Ŀ�����
    [Target, Targetposition, Signal] = Updated_Target(Targetnum, Target, UAV, Para, t, TT, Signal, w);
    %��ƽ̨/Ŀ���˶��켣
    [UAV, Target, route, Troute] = DrawTrack(t, UAVnum, Targetnum, UAV, Target, UAVposition, Targetposition, route, Troute, Para);
    %��Ƶ����Ϣ��(���������Ƶ����Ϣ��ֵ��
%     for i = 1:1:k
%         for j = 1:1:size(UAV(1).Fre,2)
%             Grid_set_FrePheromone(i,j) = Run_Grid_set(i).FrePheromone(j,1);
%         end
%     end
%     gridnum = zeros(size(Grid_set,1),length(fre0));
%     for i = 1:length(Grid_set)
%         gridnum(i,:) = i;
%     end
%     fre0 = 2:0.2:6;
%     fre = zeros(length(fre0),size(Grid_set,1));
%     for i = 1:length(fre0)
%         fre(i,:) = fre0(i);
%     end
%     plot3(gridnum,fre0,Grid_set_FrePheromone'); %�����С�Ƶ����Ϣ����
%     xlabel('��������/km');
%     ylabel('Ƶ��/GHz');
%     zlabel('��Ϣ��');
%     title('Ƶ����Ϣ��');
%     grid on;
%     for i = 1:length(Grid_set)
%         gridnum(i) = i;
%     end
%     mesh(gridnum,fre0,Grid_set_FrePheromone')
    %��Ƶ����Ϣ�أ�����Ƶ���ڵ�ͼ�ϵ���Ϣ��ֵ��
%     for i = 1:1:k
%         for j = 1:1:size(UAV(1).Fre,2)
%             Grid_set_FrePheromone(i,j) = Run_Grid_set(i).FrePheromone(j,1);
%         end
%     end
%     UAVFre = UAV.Frequency;
%     Fre = UAV(1).Fre(8);
%     x = unique(Grid_set(:,1));
%     y = unique(Grid_set(:,2));
%     oneFrePheromonemap = Get_onePheromone(UAVFre, Grid_set, Grid_set_FrePheromone, Fre, 1);
%     subplot(1,2,2);
%     set(gca, 'Units', 'normalized', 'Position', [0.585 0.105 0.395 0.795]);
%     mesh(x,y,oneFrePheromonemap);
%     xlabel('����/km');
%     ylabel('�����/km');
%     zlabel('1-��Ϣ��');
%     title([num2str(Fre/1e9),'GHzƵ����Ϣ�طֲ�']);
%     hold on;
    %��Ƶ����Ϣ�أ��ڵ�ͼ�ϵ�������Ϣ��ֵ��
%     for i = 1:1:k
%         for j = 1:1:size(UAV(1).Fre,2)
%             Grid_set_FrePheromone(i,j) = Run_Grid_set(i).FrePheromone(j,1);
%         end
%     end
%     UAVFre = UAV.Frequency;
%     Fre = UAV(1).Fre(8);
%     x = unique(Grid_set(:,1));
%     y = unique(Grid_set(:,2));
%     oneFrePheromonemap = Get_onePheromone(UAVFre, Grid_set, Grid_set_FrePheromone, Fre, 0);
%     subplot(1,2,2);
%     set(gca, 'Units', 'normalized', 'Position', [0.585 0.105 0.395 0.795]);
%     mesh(x,y,oneFrePheromonemap);
%     xlabel('����/km');
%     ylabel('�����/km');
%     zlabel('1-��Ϣ��');
%     title('��Ϣ�طֲ�');
%     hold on;
    %��֪Ŀ��
    if discovertime(1) < Tend  && discovertime(2) < Tend && discovertime(3) < Tend 
        cnt = 0;
        for j = 1:1:UAVnum
            UAV(j).vp_position = Target(4).position;
            [get_target(4,j), UAV(j)] = Get_Target(UAV(j), Target(4));
            if get_target(4,j)
                cnt = cnt + 1;
            end
        end
        if cnt >= 3
            disturbtime = t;
            TarFtime(tnum+1,:) = discovertime
            dtime(tnum+1,:) = disturbtime
        end
    end
    for i = 1:1:Targetnum
        for j = 1:1:UAVnum
            if i == 4
                if discovertime(3) < Tend
                     [get_target(i,j), UAV(j)] = Get_Target(UAV(j), Target(i));
                end
            else
                [get_target(i,j), UAV(j)] = Get_Target(UAV(j), Target(i));  %���ش洢PDW��� 
                get_target(i,j) = CheckTarget(get_target(i,j), UAV(j), j, t);
            end
            if Target(i).sign && Signal && get_target(i,j)
                discovertime(i) = t;      %����ʱ��
                TarFtime(tnum+1,:) = discovertime
                dtime(tnum+1,:) = disturbtime
                Maxdistime = max(discovertime);
                Sumdistime = sum(discovertime)/Targetnum;
                F = 1;
                Target(i).sign = 0;%�źŸ�֪��ʶ 1���ظ���֪
%                 for q = 1:k
%                     if sqrt(sum((Run_Grid_set(q).position - UAV(j).position).^2,2)) < UAV(j).R - (2 * (Para.Unit/2) / 3)
%                         angle = abs(derec(UAV(j).position,Run_Grid_set(q).position) - derec(UAV(j).position,Target(i).position));
%                         if angle > 180
%                             angle = abs(angle - 360);
%                         end
%                         if (angle <= UAV(j).location_bean_wd)
%                             Run_Grid_set(q).warning = 1;
%                             [f0,~] = find(Run_Grid_set(q).FrePheromone(:,3) == UAV(j).Fre(UAV(j).f0));
%                             Run_Grid_set(q).FrePheromone(f0,1) = 1000 * Run_Grid_set(q).FrePheromone(f0,1);
%                         end
% %                         Run_Grid_set(q).TotalPhe = mean(Run_Grid_set(q).FrePheromone(:,1));
%                     end
%                 end
%                 [~,UAV(j).u0] = min(abs(turn_angle(:)-UAV(j).PDW.direction));
                if Target(i).type == 0
                    S(j) = 0;%ʶ��Ŀ���ʶ
                    num = num + 1;
%                     UAV(j).ivp_position = [];
%                     ClosetoPosition = Circleposition(Target(i).position(1), Target(i).position(2), UAV(j).position, 3, 100, 1);
%                     UAV(j).vp_position = ClosetoPosition;    %��Ŀ��ֽ�
                else
                    S(j) = 2;
                    num = num + 1;
%                     UAV(j).ivp_position = [];
%                     ClosetoPosition = Circleposition(Target(i).position(1), Target(i).position(2), UAV(j).position, 3, 100, 1);
%                     UAV(j).vp_position = ClosetoPosition;    %��Ŀ��ֽ�
                end
            end
        end
    end
    
    %�������򸲸���
    p0 = 0;
    for k0 = 1:1:k
        if Run_Grid_set(k0).TotalPhe > 1
            RTotalPhe = 0;
        else
            RTotalPhe = Run_Grid_set(k0).TotalPhe;
        end
        p0 = (1-RTotalPhe)+p0;
    end
    FG(t,1) = (((Para.Unit)^2)*(p0))/(Para.MapL*Para.MapW)*100;
%     subplot(1,2,2);
%     set(gca, 'Units', 'normalized', 'Position', [0.585 0.105 0.395 0.795]);
%     plot(FG);
%     xlabel('ʱ��/s');
%     ylabel('������');
%     title('����������');
%     hold on;
%     
    %����Ŀ��
    for U = 1:1:UAVnum
        T = t;
        if S(U) == 0
%             disp(['UAV_',num2str(U),'����',num2str(T),'�����������вĿ��']); 
%             disp(['UAV_',num2str(U),'������Ϊ����вAĿ��,Ŀ��Ƶ��',num2str(UAV(U).PDW.Fre),'Hz,����',num2str(UAV(U).PDW.Width),'s,λ��',num2str(UAV(U).PDW.direction),'�㷽��,���Ͷ�λ����ָ����Ⱥ����Ŀ�궨λ']); 
            S(U) = -1;
            F1 = 1;
            e = 1;
        elseif S(U) == 2
%             disp(['UAV_',num2str(U),'����',num2str(T),'�����������вĿ��']);
%             disp(['UAV_',num2str(U),'������Ϊ����вBĿ��,Ŀ��Ƶ��',num2str(UAV(U).PDW.Fre),'Hz,����',num2str(UAV(U).PDW.Width),'s,λ��',num2str(UAV(U).PDW.direction),'�㷽��,���Ͷ�λ����ָ����Ⱥ����Ŀ�궨λ']); 
            S(U) = -1;
            F2 = 1;
            e = 1;
        elseif S(U) == 1
            S(U) = 1;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %���㷢��Ŀ��ʱ��
%     if F1 && F2 
%         e2 = 1;
%         Gra = Gra + T;    %�ۼ�ʱ��
%     elseif ~e2 && (F1 || F2)
%         e1 = 1;
%     end
%     if e2 && e
%         F2_SuccN = F2_SuccN + 1;    %�ɹ���������Ŀ��
%         subplot(1,2,2);
%         set(gca, 'Units', 'normalized', 'Position', [0.585 0.105 0.395 0.795]);
%         plot(FG);
%         xlabel('ʱ��/s');
%         ylabel('������');
%         title('����������');
% %         set(gca,'XTick',0:10:Tend*10);
% %         set(gca,'XTicklabel',xlab);
%         hold on;
%         pause(5);
%         break;
%     elseif e1 && e 
%         F1_SuccN = F1_SuccN + 1;    %�ɹ�����һ��Ŀ��
% %         subplot(1,2,2);
% %         set(gca, 'Units', 'normalized', 'Position', [0.585 0.105 0.395 0.795]);
% %         plot(FG);
% %         xlabel('ʱ��/s');
% %         ylabel('������');
% %         title('����������');
% %         set(gca,'XTicklabel',xlab);
% %         hold on;
%         e = 0;
%         e1 = 0;
%     end

    %δ����Ŀ��
%     if F
%         subplot(1,2,2);
%         set(gca, 'Units', 'normalized', 'Position', [0.585 0.105 0.395 0.795]);
%         plot(FG);
%         xlabel('ʱ��/s');
%         ylabel('������');
%         set(gca,'ylim',[0 100]);
%         title('����������');
% %         set(gca,'XTicklabel',xlab);
%         hold on;
%         pause(3);
%         SuccN = SuccN + 1;
%         Ftime = [Ftime,discovertime]
%         break;
%     end
    if t == Tend
        subplot(1,2,2);
        set(gca, 'Units', 'normalized', 'Position', [0.585 0.105 0.395 0.795]);
        plot(FG);
        xlabel('ʱ��/s');
        ylabel('������');
        set(gca,'ylim',[0 100]);
        title('����������');
%         set(gca,'XTicklabel',xlab);
        hold on;
        pause(3);
        if F
            SuccN = SuccN + 1;
            MaxFtime = [MaxFtime,Maxdistime]
            Ftime = [Ftime,Sumdistime];
%             for i = 1:Targetnum
%                 Dnum(i) = Target(i).sign;
%             end
%             discovernum = size(find(Dnum == 0),2);
%             Fnum = [Fnum,discovernum]
        else
            FailN = FailN + 1;   %����time��ʱ��û�з���Ŀ�꼴����ʧ��
        end
        [rows,~] = size(FG);
        averageFG = [averageFG,FG(rows)]
        break;
    end

    hold off;       %ֻ�����յ�λ��Ϊo
%     xlab(tt+1) = t;
    t = t + 1;
    pause(0.1);
    
end

tnum = tnum + 1
if tnum == TNUM
%     N2 = F2_SuccN/(F2_SuccN+FailN);
%     N2 = N2 * 100;
%     N1 = F1_SuccN/(F2_SuccN+FailN);
%     N1 = N1 * 100;
%     disp(['ȫ��Ŀ�귢�ָ���Ϊ',num2str(N2),'%']);
%     disp(['����Ŀ�귢�ָ���Ϊ',num2str(N1),'%']);
%     Gra = Gra/TNUM;
%     disp([num2str(TNUM),'������Ŀ�귢��ƽ��ʱ��Ϊ',num2str(Gra),'s']);
    N = SuccN/(SuccN+FailN);     
    N = N * 100;
    TarFtime    %��ӡÿ��Ŀ�귢��ʱ��
    dtime
    disp(['Ŀ�귢�ָ���Ϊ',num2str(N),'%']);
    if ~isempty(Ftime)
        averagemaxFtime = mean(MaxFtime);
        averageFtime = mean(Ftime);
        MaxFtimevar = sqrt(sum((MaxFtime(1,:)-mean(MaxFtime)).^2)/length(MaxFtime));
        Ftimevar = sqrt(sum((Ftime(1,:)-mean(Ftime)).^2)/length(Ftime));
        disp([num2str(TNUM),'�����鷢������Ŀ��ƽ��ʱ��Ϊ',num2str(averagemaxFtime),'s','����Ϊ',num2str(MaxFtimevar)]);
        disp([num2str(TNUM),'������ƽ��Ŀ�귢��ʱ��Ϊ',num2str(averageFtime),'s','����Ϊ',num2str(Ftimevar)]);
    end
    AverageFG = mean(averageFG);
    AverageFGvar = sqrt(sum((averageFG(1,:)-mean(averageFG)).^2)/length(averageFG));
    disp([num2str(TNUM),'������ƽ��������Ϊ',num2str(AverageFG),'%','����Ϊ',num2str(AverageFGvar)]);
    break;
end

end

