matlab_blue = [0,114,189]/255;
matlab_orange = [217,83,25]/255;
matlab_purple = [126, 47, 142]/255;
matlab_green = [119, 172, 48]/255;
av = [av_re(1,:,4)];
av=reshape(av,1,5);
th = [av_re(2,:,4)];
th=reshape(th,1,5);

%p1 = plot(ESS(1, :),'^--', 'Color', matlab_blue, 'LineWidth', 1.5);
%figure

plot([0.05:0.05:0.25],av,'--^','Color', matlab_orange, 'linewidth',2)
%hold on
plot([0.05:0.05:0.25],th,'-^','Color', matlab_orange,'linewidth',2)
% axis([0.2 1 0 1])

% scatter([0:0.1:1],av_re(21,:),'o')
% hold on
% plot([0:0.1:1],th_all(21,:),'linewidth',2)


% title('��ͬ�����û�����Ӱ���µĽ��pl�仯ͼ')
% xlabel('�����û������ı��� beta')
% ylabel('��Ⱥ�г�ʵ�û������������pl')
% %text(ans,th,'ͼ��˵��')
%  legend('eps=0.05������','eps=0.05���۽��','eps=0.2������','eps=0.2���۽��')
% % save('tmp.mat')
%   saveas(gcf,'��ͬ�����û�������Ӱ����.jpg')