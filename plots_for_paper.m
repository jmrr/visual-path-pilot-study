plot(x(2:end),smooth(pdfPooled{1}(2:end)))
hold on;plot(x(2:end),smooth(pdfPooled{2}(2:end)))
hold on;plot(x(2:end),smooth(pdfPooled{3}(2:end)))
plotperformance(stats_pdf(:,2:end),SUP(2:end),'r','-','.',0.2)

%%

[stats_pdf] = getMeanAndStdCombinedPdfs(pdf,4:9);

plot(x,smooth(pdf{1}))
hold on
plot(x,smooth(pdf{2}))
plot(x,smooth(pdf{3}))

plotperformance(stats_pdf,SUP,'r','-','.',0.2)




