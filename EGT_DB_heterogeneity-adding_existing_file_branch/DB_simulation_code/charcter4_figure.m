figure
plot([0.05:0.01:0.25],fusion_rate_all(1,1:21),'linewidth',1.5)
axis([0.05 0.25 0 1])

hold on
plot([0.05:0.01:0.25],fusion_rate_all(2,1:21),'linewidth',1.5)
plot([0.05:0.01:0.25],fusion_rate_all(3,1:21),'linewidth',1.5)
plot([0.05:0.01:0.25],fusion_rate_all(4,1:21),'linewidth',1.5)




title('四种方法对eps的灵敏度分析 beta=0.3')
xlabel('系统误差 eps')
ylabel('FC的融合正确率')
%text(ans,th,'图形说明')
 legend('HardIS正确率','SoftIS正确率','MAP正确率','IM-MAP正确率')
% save('tmp.mat')
 %saveas(gcf,'beta灵敏度分析.jpg')