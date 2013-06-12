function [y] = lowpassf(x,c)

%c=filter constant.bigger-->more filtering


a=0.01/c;
y = filter(a, [1 a-1], x);

end %end function