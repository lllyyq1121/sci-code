figure
plot([0.05:0.01:0.25],fusion_rate_all(1,1:21),'linewidth',1.5)
axis([0.05 0.25 0 1])

hold on
plot([0.05:0.01:0.25],fusion_rate_all(2,1:21),'linewidth',1.5)
plot([0.05:0.01:0.25],fusion_rate_all(3,1:21),'linewidth',1.5)
plot([0.05:0.01:0.25],fusion_rate_all(4,1:21),'linewidth',1.5)




title('���ַ�����eps�������ȷ��� beta=0.3')
xlabel('ϵͳ��� eps')
ylabel('FC���ں���ȷ��')
%text(ans,th,'ͼ��˵��')
 legend('HardIS��ȷ��','SoftIS��ȷ��','MAP��ȷ��','IM-MAP��ȷ��')
% save('tmp.mat')
 %saveas(gcf,'beta�����ȷ���.jpg')