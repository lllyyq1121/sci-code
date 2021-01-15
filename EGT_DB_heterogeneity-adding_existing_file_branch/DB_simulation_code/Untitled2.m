clear all;
N = 100;
iter = 8  ;
eps=0.1;
beta = 0.1;
times = 100;
% hard_rate_noin = zeros(1,times);
% soft_rate_noin = zeros(1,times);
% map_rate_noin = zeros(1,times);
av_hard_in_tmp = 0;% i eps j beta
av_soft_in_tmp = 0;
av_map_in_tmp = 0;

av_hard_no_tmp = 0;
av_soft_no_tmp =0;
av_map_no_tmp = 0;
av_re_tmp = 0;
be = beta/(1-beta);
%av_re= av_re + sum(ans)/iter;
for i = 1:times
    DBsim_eps_fusion(0.0001,N,iter,0.1,1,eps,be);
        av_re=   sum(ans)/iter;
  %  hard_rate_influence(i) =hard_isolation(N,iter,0);
 %   soft_rate_influence(i) =soft_isolation(N,iter,0,eps,beta);
    map_rate_influence(i) = map_fusion_new(N,iter,0,eps,beta);

%     hard_rate_noin(i) = hard_isolation(N,iter,1);
%     soft_rate_noin(i) = soft_isolation(N,iter,1,eps,beta);
%     map_rate_noin(i) = map_fusion(N,iter,1,eps,beta);
end
  av_re=   sum(ans)/iter
for i =1:times
   % av_hard_in_tmp = av_hard_in_tmp + hard_rate_influence(i);
  %  av_soft_in_tmp = av_soft_in_tmp + soft_rate_influence(i);
    av_map_in_tmp = av_map_in_tmp + map_rate_influence(i);
%     av_hard_no_tmp = av_hard_no_tmp + hard_rate_noin(i);
%     av_soft_no_tmp = av_soft_no_tmp + soft_rate_noin(i);
%     av_map_no_tmp = av_map_no_tmp + map_rate_noin(i);
end

   % av_hard_in_tmp = av_hard_in_tmp/times
  %  av_soft_in_tmp = av_soft_in_tmp /times
    av_map_in_tmp = av_map_in_tmp/times
%     av_hard_no_tmp = av_hard_no_tmp/times
%     av_soft_no_tmp = av_soft_no_tmp/times
%     av_map_no_tmp = av_map_no_tmp/times