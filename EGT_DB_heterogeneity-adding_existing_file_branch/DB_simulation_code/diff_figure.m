function y = diff_figure(alpha,N,k,eps,beta,p_ini,iter)
 %   syms pl;
    delta =-0.4;
    delta_n =-0.2;
    delta_l =0;
%     delta =-0.2;
%     delta_n =-0.1;
%     delta_l =-0.2;
    y = zeros(1,iter);
    y(1) = p_ini;
    for i = 2:iter
        pl = y(i-1);
        epl=2 *(1 - eps)* eps+(1 - 2 *eps)^2 *(beta + pl)/(1 + beta) + k * alpha*(1 - 2 *eps)^2 *((1/(k + k*beta)^3)* delta *(1 - 2* eps)^2 *(k^3 *beta^3 + k *pl +3 *k^3 *beta^2 *pl + 3 *(-1 + k)* k *pl^2 + (-2 + k) *(-1 + k)* k *pl^3 + 3 *k *beta *(k *pl - k *pl^2 + k^2 *pl^2)) - (-1 + eps) *eps *delta_n + ((k* beta + k * pl)* (delta + delta* (-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps *delta_n))/(k + k* beta) - (1/(k + k* beta)^2)* (k^2* beta^2 + k * pl + 2 *k^2 *beta *pl - k*pl^2  + k^2 *pl^2)* (2* delta + 4 *delta *(-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps* delta_n));
        eq=- pl *(1-epl)+(1-pl)*epl;
        y(i) = y(i-1) + eq;
    end
%     figure
%     plot(y)
%     axis([0 300 0 1])
end