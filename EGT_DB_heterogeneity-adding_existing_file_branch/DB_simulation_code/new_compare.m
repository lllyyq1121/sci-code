clear all;
N=100;
iter = 8;
eps = 0.2;
be = 0.35;
beta = be/(1-be);
times = 100;
old=0;
new=0;

for i =1:times
    result = DBsim_eps_fusion(0.001,N,iter,0.1,1,eps,beta);
    rho = sum(result)/iter;
    old = old+map_fusion(N,iter,0,eps,be);
    new = new+map_fusion_new(N,iter,0,eps,be,rho);
end
rho
old= old/times
new = new/times