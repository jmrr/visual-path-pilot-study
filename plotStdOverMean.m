function [] = plotStdOverMean(mean,std,color_mean,style_mean,color_std,style_std,alpha)

support = 0:1:length(mean)-1;

lower_support = [support, fliplr(support)];

upper_lim = mean + std;
lower_lim = mean - std;

upper_support = [upper_lim, fliplr(lower_lim)];

fill( lower_support , upper_support, color_std,'facealpha',alpha,...
    'edgecolor',color_std,'edgealpha',0.6,'linestyle',style_std)
hold on
plot(support,mean,'linestyle',style_mean,'Color',color_mean');
end % end of plotStdOverMean