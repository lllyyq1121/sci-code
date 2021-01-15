clear all;
rate1=0;
rate2=0;
rate3=0;
rate4=0;
rate5=0;
rate6=0;
rate=0;
N=100;
iter=120;
eps=0.10;
beta=0.9;
%for i= 1:10
g = createRandRegGraph(100, 5);
 g = graph_change(full(createRandRegGraph(100, 5)));
 DBsim_eps_fusion2(0.0001,g, N,iter, 0.2, 1,eps,beta);
 map_fusion2(100,5,0.2,iter,0,eps,50)
%  rate1=rate1+map_fusion2(100,5,0.2,300,0,0.1,25);
%   DBsim_eps_fusion2(0.0001,g, N,iter, 0.2, 1,0.1,0.3);
%  rate2=rate2+map_fusion2(100,5,0.2,300,0,0.1,25);
%    DBsim_eps_fusion2(0.0001,g, N,iter, 0.2, 1,0.1,0.4);
%  rate3=rate3+map_fusion2(100,5,0.2,300,0,0.1,25);
%  %rate1=rate1+map_fusion_new(N,300,0,eps,beta,0.720688);
% %rate2=rate2+map_fusion(N,iter,0,eps,beta);
% %rate3=rate3+map_fusion(N,iter,1,eps,beta);
 %end
 %rate=rate/10
% rate2=rate2/5
% rate3=rate3/5
