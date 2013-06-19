windowSize = 20;
b = ones(1,windowSize)/windowSize;
a= 1;

span = 20;
figure('Renderer','zbuffer')
plot(Dplots(1,:));
axis([1 size(distances,1) 0 1])
set(gca,'NextPlot','replaceChildren');
% Preallocate the struct array for the struct returned by getframe
F(size(distances,1)) = struct('cdata',[],'colormap',[]);
% Record the movie
averagedSignal = zeros(size(distances));
for j = 1:size(distances,1)
    %plot(smooth(D(j,:)));
    averagedSignal(j,:) = filter(b,a,Dplots(j,:));
    plot(averagedSignal(j,:));
    hold on;
    [maxValAV,idxmaxAV] = max(averagedSignal(j,:));
    plot(idxmaxAV,maxValAV,'rs','LineWidth',2,'MarkerFaceColor','g','MarkerSize',10);
    if((idxmaxAV+span<=length(averagedSignal(j,:)))&&(idxmaxAV-span)<1)
        xaxisRed = idxmaxAV-span:idxmaxAV+span;
        plot(xaxisRed,averagedSignal(j,xaxisRed),'r');
    end
    axis([1 size(distances,2) 0 1])
    F(j) = getframe;
    hold off;
end
% 
% [h, w, p] = size(F(1).cdata);
% hf = figure; 
% % resize figure based on frame's w x h, and place at (150, 150)
% set(hf,'Position', [150 150 w h]);
% axis off
% % Place frames at bottom left
% movie(hf,F,1,2,[0 0 0 0]);
