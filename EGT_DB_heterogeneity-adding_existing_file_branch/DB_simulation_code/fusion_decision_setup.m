clear all;
N = 100;
iter = 8 ;
%fusion_rate_all = zeros(6 , 50,11);
fusion_rate_all = zeros(4 ,40);
% %            av_hard_in(I,J) = av_hard_in / times
%             av_soft_in(I,J) = av_soft_in / times
%             av_map_in(I,J) = av_map_in / times
%             av_hard_no(I,J) = av_hard_no / times
%             av_soft_no(I,J) = av_soft_no / times
%             av_map_no(I,J) = av_map_no / times

times = 100;

av_hard_in_tmp = 0;% i eps j beta
av_soft_in_tmp = 0;
av_map_in_tmp = 0;

av_hard_no_tmp = 0;
av_soft_no_tmp =0;
av_map_no_tmp = 0;
av_new_in_tmp = 0;
av_re_tmp = 0;

av_hard_in = zeros(50,20);% i eps j beta
av_soft_in = zeros(50,20);
av_map_in = zeros(50,20);
av_new_in = zeros(50,20);

av_hard_no = zeros(50,20);
av_soft_no =zeros(50,20);
av_map_no = zeros(50,20);
av_re = zeros(50,20);


eps = 0.05;
beta = 0.3;
for I = 1 :1
    for J = 1:21
        av_hard_in_tmp = 0;% i eps j beta
        av_soft_in_tmp = 0;
        av_map_in_tmp = 0;
        av_new_in_tmp = 0;

        av_hard_no_tmp = 0;
        av_soft_no_tmp =0;
        av_map_no_tmp = 0;
        av_new_no_tmp = 0;
        av_re_tmp = 0;
        
        hard_rate_influence =zeros(1,times);
        soft_rate_influence =zeros(1,times);
        map_rate_influence = zeros(1,times);
        new_rate_influence = zeros(1,times);
        hard_rate_noin =zeros(1,times);
        soft_rate_noin =zeros(1,times);
        map_rate_noin = zeros(1,times);
        new_rate_influence = zeros(1,times);

        be = beta/(1-beta);
        
        for i = 1:times
            DBsim_eps_fusion(0.001,N,iter,0.1,1,eps,be);
           av_re= sum(ans)/iter;
            hard_rate_influence(i) =hard_isolation(N,iter,0);
            soft_rate_influence(i) =soft_isolation(N,iter,0,eps,beta);
            map_rate_influence(i) = map_fusion(N,iter,0,eps,beta);
            new_rate_influence(i) = map_fusion_new(N,iter,0,eps,beta,av_re);

%             hard_rate_noin(i) = hard_isolation(N,iter,1);
%             soft_rate_noin(i) = soft_isolation(N,iter,1,eps,beta);
%             map_rate_noin(i) = map_fusion(N,iter,1,eps,beta);
        end

        for i =1:times
            av_hard_in_tmp = av_hard_in_tmp + hard_rate_influence(i);
            av_soft_in_tmp = av_soft_in_tmp + soft_rate_influence(i);
            av_map_in_tmp = av_map_in_tmp + map_rate_influence(i);
            av_new_in_tmp = av_new_in_tmp +new_rate_influence(i);
%             av_hard_no_tmp = av_hard_no_tmp + hard_rate_noin(i);
%             av_soft_no_tmp = av_soft_no_tmp + soft_rate_noin(i);
%             av_map_no_tmp = av_map_no_tmp + map_rate_noin(i);
        end

         %   av_re(I,J) = av_re/times;

            av_hard_in(I,J) = av_hard_in_tmp / times;
            av_soft_in(I,J) = av_soft_in_tmp / times;
            av_map_in(I,J) = av_map_in_tmp / times;
            av_new_in(I,J) = av_new_in_tmp / times;
%             av_hard_no(I,J) = av_hard_no_tmp / times;
%             av_soft_no(I,J) = av_soft_no_tmp / times;
%             av_map_no(I,J) = av_map_no_tmp / times;
            
            
 %           fusion_rate_all(:,J) = [av_hard_in(I,J),av_soft_in(I,J),av_map_in(I,J),av_hard_no(I,J),av_soft_no(I,J),av_map_no(I,J)],av_new_in(I,J);
            fusion_rate_all(:,J) = [av_hard_in(I,J),av_soft_in(I,J),av_map_in(I,J),av_new_in(I,J)];
            eps = eps +0.01;
    end
    eps = eps +0.01;
    beta = 0.0 ;
end
save('./result/fusion_rate_4_5_eps_b0.3.mat')
% figure
% scatter([1:1:iter],ans)
% axis([0 iter 0 1])