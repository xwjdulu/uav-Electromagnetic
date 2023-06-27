%����Բ�Ĺ̶�����ĵ�
function [position] = Circleposition(x, y, p, r, nseg, minflag, Para)
%%x��y��Բ���������꣬r�ǰ뾶��nseg�Ǳ�Ե������Խ�ߣ���ԵԽ˳��������100���ϣ���S��plot����ʽ�����ַ�

theta = 0 : (2 * pi / nseg) : (2 * pi);
pline_x = r * cos(theta) + x;
pline_y = r * sin(theta) + y;
position(:,1) = pline_x.';
position(:,2) = pline_y.';
if minflag
    dist = sqrt(sum((position - p).^2,2));
    [~,index] = min(dist);
    position = position(index,:);
else
    j = 1;
    dposition = [];
    for i = 1:1:nseg
        if position(i,1) <= Para.MapL && position(i,1) >= 0 && position(i,2) <= Para.MapW && position(i,2) >= 0
            dposition(j,:) = position(i,:);
            j = j + 1;
        end
    end
    position = dposition(randi(j-1),:);
end