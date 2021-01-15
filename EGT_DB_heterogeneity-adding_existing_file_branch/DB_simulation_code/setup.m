%clear all;
matlab_blue = [0,114,189]/255;
matlab_orange = [217,83,25]/255;
matlab_purple = [126, 47, 142]/255;
matlab_green = [119, 172, 48]/255;

syms pl;
N = 1000;
k=10;
alpha =0.0001;
delta =-0.4;
delta_n =-0.2;
delta_l =0;
% delta =-0;
% delta_n =-0.2;
% delta_l =-0.2;
eps=0.1;
beta = 0.3;
p_ini = 0.2;
iter = 300;


sim = DBsim_meaneps('scale-free',alpha,N,k,iter,p_ini,1,eps,beta);
theo = diff_figure(alpha,N,k,eps,beta,p_ini,iter);
% epl=2 *(1 - eps)* eps+((1 - 2 *eps)^2 *(beta + pl))/(1 + beta) + k * alpha*(1 - 2 *eps)^2 *((1/(k + k*beta)^3)* delta *(1 - 2* eps)^2 *(k^3 *beta^3 + k *pl +3 *k^3 *beta^2 *pl + 3 *(-1 + k)* k *pl^2 + (-2 + k) *(-1 + k)* k *pl^3 + 3 *k *beta *(k *pl - k *pl^2 + k^2 *pl^2)) - (-1 + eps) *eps *delta_n + ((k* beta + k * pl)* (delta + delta* (-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps *delta_n))/(k + k* beta) - (1/(k + k* beta)^2)* (k^2* beta^2 + k * pl + 2 *k^2 *beta *pl - k*pl^2  + k^2 *pl^2)* (2* delta + 4 *delta *(-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps* delta_n));
% eq= -pl *(1-epl)+(1-pl)*epl;
% s=solve(eq,pl,'Real',true) ;
% th= double(s)
%p1 = plot(ESS(1, :),'^--', 'Color', matlab_blue, 'LineWidth', 1.5);
figure
plot(sim,'--','Color', matlab_blue,'linewidth',1.5)
axis([0 100 0 1])
hold on;
plot(theo,'Color', matlab_blue,'linewidth',1.5)
% % 
% % % delta =-0;
% % % delta_n =-0.2;
% % % delta_l =-0.2;
simm = DBsim_meaneps('scale-free',alpha,N,k,iter,p_ini,1,eps,0.5);
 theoo = diff_figure(alpha,N,round(N/(1+beta)),eps,0.5,p_ini,iter);
plot(simm,'--','Color', matlab_purple,'linewidth',1.5)
plot(theoo,'Color', matlab_purple,'linewidth',1.5)

simmm = DBsim_meaneps('scale-free',alpha,N,k,iter,p_ini,1,eps,0.8);
 theooo = diff_figure(alpha,N,round(N/(1+beta)),eps,0.8,p_ini,iter);
plot(simmm,'--','Color', matlab_orange,'linewidth',1.5)
plot(theooo,'Color', matlab_orange,'linewidth',1.5)

% simmm = DBsim_meaneps(alpha,N,iter,p_ini,1,0.2,beta);
% theooo = diff_figure(alpha,N,round(N/(1+beta)),0.2,beta,p_ini,iter);
% scatter([1:1:iter],simmm)
% axis([0 iter 0 1])
% plot(theooo,'linewidth',2)

% title('动态演化过程图 PM1 PM2 PM3')
 xlabel('Time Index')
 ylabel('pl')
% %text(ans,th,'图形说明')
%  legend('PM1仿真结果','PM1理论结果','PM2仿真结果','PM2理论结果','PM3仿真结果','PM3理论结果')
% % save('tmp.mat')
%   saveas(gcf,'动态演化过程图 PM1PM2PM3.jpg')