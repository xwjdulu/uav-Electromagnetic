%����һ������������������亯�����������룬�ֱ��������������С�����Բ�뾶�������ο�Ⱥ͸߶ȡ�
%rc= �������Բ�뾶
%Width=���ο��
%Height=��������Ŀ��

function [V,k] = HexagonDraw(rc,Width,Height)
%rc= �������Բ�뾶
%Width=���ο��
%Height=��������Ŀ��

%     scrsz = get(0,'ScreenSize');
%     myCir=figure('Position',[50 50 600 600]);   % ���û�ͼ����ͼλ�úʹ�С
%     figure(myCir);
%     xlim([0 Width]);    %����ͼ�����������
%     ylim([0 Height]);
%     hold on;
%%%%%%%%%%%%%%%%%%%
dx=1.5*rc;
dy=rc*sqrt(3)/2;
A=[0:pi/3:2*pi];
px=rc*cos(A);  
py=rc*sin(A);

mx=ceil(Width/dx);
my=ceil(Height/dy);
%%%%%%%%%%%%%%%%%%
V = [];
k=1;
for i=[0:mx]
    for j=[1:my-1]
        if mod((i+j),2)==0 && (i*dx)<=Width && (j*dy)<=Height
            xp=i*dx;yp=j*dy;
            V(k,:)=[xp yp];
            k=k+1;
%             plot(px+xp,py+yp,'k','linewidth',0.5);
%             fill(px+xp,py+yp,'k','facealpha',0.5);
%             plot(xp,yp,'.','markersize',3);
        end
    end
end

%%%%%%%%%%%%%%%
k = k-1;
hold on;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

