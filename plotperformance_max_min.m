function plotperformance_max_min(M,support,color,style,style1,alpha)

% M=mean(var,2);
% S=std(var,0,2);
%{
i=find(S==0);
m=mean(S);
S(i)=m;
[R,id]=sort(M);
f = [R+1.42*(S(id)); R(end:-1:1)-1.42*(S(id(end:-1:1)))];
c=[1:101,101:-1:1]';
fill(c, f, color,'facealpha',0.3,'edgecolor',color,'edgealpha',0.6,'linestyle',style)
hold on;
plot(R,'color',color,'marker',style1)
axis tight
%}
Max=M(2,:);
Min = M(3,:);
M=M(1,:);

SUP  = support;

f = M+Max; fr=M-Min;

f = [f , fliplr(fr)];

support2 = [support,fliplr(support)];
% support = [1:length(support),fliplr(1:length(support))];

fill( support2 , f, color,'facealpha',alpha,'edgecolor',color,'edgealpha',0.6,'linestyle',style)
hold on;
plot(SUP,M,'color',color,'marker',style1)
% set(gca,'XDir','Reverse');
% set(gca,'Xtick',SUP);
% set(gca,'XTickLabel',SUP);
% axis tight