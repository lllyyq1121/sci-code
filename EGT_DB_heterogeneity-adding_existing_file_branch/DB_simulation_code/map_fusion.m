function true_rate=map_fusion(N,iter,type,eps,beta)
    load('./fusion_data/sys.mat')
    load('./fusion_data/obv.mat')
    load('./fusion_data/rep.mat')
    load('./fusion_data/action.mat')
    load('./fusion_data/nodes.mat')
    load('./fusion_data/repnoin.mat')
    if(type == 1)
        rep_all = rep_noin;
    end
    summ = 0;
     beta = beta/(1+beta);
    m = 6;
    sys_decision = zeros(1,iter);
    true_rate = 0;
    for W =1:idivide(int32(iter),int32(m),'floor')%iter/m
        rep_tmp=rep_all(:,(W-1)*m+1:W*m);
        pmal = 1;
  %      gamma = (1-eps)*rho+eps*(1-rho);
        delta = eps * (1-pmal) + (1-eps) * pmal;
        
        meq = zeros(1,N);
        prob = 1;
        max_prob = 0;
        max_index = 0;
        sys_tmp=dec2bin(0:2^m-1)-'0';

        for T = 1: 2^m
            meq = zeros(1,N);
            for i = 1 :N
                for j = 1:m
                    if(sys_tmp(T,j) == rep_tmp(i,j))
                        meq(i) = meq(i) +1;
                    end
                end
            end

            for i = 1:N
               prob = prob * ((1-beta)*(1-eps)^meq(i)*eps^(m-meq(i))+beta*(1-delta)^meq(i)*delta^(m-meq(i))) ;
            end

            if(prob > max_prob)
                max_prob = prob;
                max_index = T;
            end
            prob = 1;
        end
        sys_decision(1,(W-1)*m+1:W*m) = sys_tmp(max_index,:);
    end
%     sys_decision = sys_tmp(max_index,:);
    for i = 1 : iter
        if(sys_decision(i) == sys_all(i))
            summ = summ + 1;
        end
    end
    true_rate = summ/iter;
    
    
end