iter = 300;
syms pl;
N=1000;
k=10;
alpha =0.0001;
delta =-0.4;
delta_n =-0.2;
delta_l =0;
 result_mean_list = zeros(2,5, 5,iter, 'double');
av_re = zeros(2,5,5,'double');
eps = 0.05;
beta = 0.2;
for i = 1 : 5 %eps
    for j = 1:5 %beta
        result_mean_list(1,i,j,:) =DBsim_meaneps(  'scale-free',0.0001,1000,10 ,300, 0.2, 1, eps ,beta);
 %       result_mean_list(2,i,j,:) =DBsim_meaneps(  'scale-free',0.0001,1000,10 ,300, 0.6, 1, eps ,beta);
        av_re(1,i,j)= sum(result_mean_list(1,i,j,201:300))/100;%regular ans
  %      av_re(2,i,j)= sum(result_mean_list(2,i,j,201:300))/100;%scale-free ans
        %thoery
        epl=2 *(1 - eps)* eps+((1 - 2 *eps)^2 *(beta + pl))/(1 + beta) + k * alpha*(1 - 2 *eps)^2 *((1/(k + k*beta)^3)* delta *(1 - 2* eps)^2 *(k^3 *beta^3 + k *pl +3 *k^3 *beta^2 *pl + 3 *(-1 + k)* k *pl^2 + (-2 + k) *(-1 + k)* k *pl^3 + 3 *k *beta *(k *pl - k *pl^2 + k^2 *pl^2)) - (-1 + eps) *eps *delta_n + ((k* beta + k * pl)* (delta + delta* (-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps *delta_n))/(k + k* beta) - (1/(k + k* beta)^2)* (k^2* beta^2 + k * pl + 2 *k^2 *beta *pl - k*pl^2  + k^2 *pl^2)* (2* delta + 4 *delta *(-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps* delta_n));
        eq= -pl *(1-epl)+(1-pl)*epl;
        s=solve(eq,pl,'Real',true) ;
        av_re(2,i,j)= double(s);%theory ans
        
        
        
        beta = beta +0.2;
    end
    eps = eps +0.05;
    beta = 0.2 ;
end
%save('result_list_all-new.mat','result_mean_list')
save('av_list_all.mat-new','av_re')
%DBsim_meaneps(0.001,1000,0.6,1,0.1,0.2)
%av_re= sum(ans(501:1000))/500
%figure
%scatter([1:1:1000],ans)
%axis([0 1000 0 1])