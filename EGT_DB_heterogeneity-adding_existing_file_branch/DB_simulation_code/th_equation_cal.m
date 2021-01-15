th_all = zeros(50,11,'double');
syms pl;
N = 1000;
%eps =0.01;
alpha =0.001;
%beta = 0.1;
k =910;


eps = 0.01;
beta = 0.0;
for i = 1 : 40 %eps
    for j = 1:11 %beta
        epl=2 *(1 - eps)* eps+(1 - 2 *eps)^2 *(beta + pl)/(1 + beta) + k * alpha*(1 - 2 *eps)^2 *((1/(k + k*beta)^3)* delta *(1 - 2* eps)^2 *(k^3 *beta^3 + k *pl +3 *k^3 *beta^2 *pl + 3 *(-1 + k)* k *pl^2 + (-2 + k) *(-1 + k)* k *pl^3 + 3 *k *beta *(k *pl - k *pl^2 + k^2 *pl^2)) - (-1 + eps) *eps *delta_n + ((k* beta + k * pl)* (delta + delta* (-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps *delta_n))/(k + k* beta) - (1/(k + k* beta)^2)* (k^2* beta^2 + k * pl + 2 *k^2 *beta *pl - k*pl^2  + k^2 *pl^2)* (2* delta + 4 *delta *(-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps* delta_n));
        eq=-1/N* pl *(1-epl)+1/N*(1-pl)*epl;
        s=solve(eq,pl,'Real',true) ;
        th_all(i,j)= double(s);
        beta = beta +0.1;
    end
    eps = eps +0.01;
    beta = 0.0 ;
end
save('th_all.mat','th_all')

%(1 - 2 *(1 - eps)* eps - ((1 - 2 *eps)^2 *(beta + pl))/(1 + beta) - k * alpha*(1 - 2 *eps)^2 *((1/(k + k*beta)^3)* delta *(1 - 2* eps)^2 *(k^3 *beta^3 + k *pl +3 *k^3 *beta^2 *pl + 3 *(-1 + k)* k *pl^2 + (-2 + k) *(-1 + k)* k *pl^3 + 3 *k *beta (k *pl - k *pl^2 + k^2 *pl^2)) - (-1 + eps) *eps *delta_n + ((k* beta + k * pl)* (delta + delta* (-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps *delta_n))/(k + k* beta) - (1/(k + k* beta)^2)* (k^2* beta^2 + k * pl + 2 *k^2 *beta *pl - k*pl^2  + k^2 *pl^2)* (2* delta + 4 *delta *(-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps* delta_n))) + 1/N*(1- pl) *( 2 *(1 - eps)* eps + ()