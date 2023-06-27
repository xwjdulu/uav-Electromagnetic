%这是一个矩形区域六边形填充函数，三个输入，分别是六边形网格大小（外接圆半径），矩形宽度和高度。
%rc= 网格外接圆半径
%Width=矩形宽度
%Height=矩形区域的宽度

function [V,k] = HexagonDraw(rc,Width,Height)
%rc= 网格外接圆半径
%Width=矩形宽度
%Height=矩形区域的宽度

%     scrsz = get(0,'ScreenSize');
%     myCir=figure('Position',[50 50 600 600]);   % 设置绘图的视图位置和大小
%     figure(myCir);
%     xlim([0 Width]);    %设置图像区域的坐标
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

