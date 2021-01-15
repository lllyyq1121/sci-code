function true_rate=map_fusion2(N,k,p_ini,iter,type,eps,h)
    load('./fusion_data/sys.mat')
    load('./fusion_data/obv.mat')
    load('./fusion_data/rep.mat')
    load('./fusion_data/action.mat')
    load('./fusion_data/nodes.mat')
    load('./fusion_data/repnoin.mat')
    if(type == 1)
        rep_all = rep_noin;
    end
    
    
    alpha = 0.001;
    delta =-0.4;
    delta_n =-0.2;
    delta_l =0;
    pmal = 1;
    det = eps * (1-pmal) + (1-eps) * pmal;
    m = 6;
    true_rate = 0;
    summ = 0;
    sys_decision = zeros(1,iter);
    for W =1:idivide(int32(iter),int32(m),'floor')%iter/m
        rep_tmp=rep_all(:,(W-1)*m+1:W*m);
        meq = zeros(1,N);
        prob = 1;
        t_prob=1;
        max_prob = 0;
        max_index = 0;

        sys_tmp=dec2bin(0:2^m-1)-'0';
        idx=[1:N];

        for T = 1: 2^m
            meq = zeros(1,N);
            for i = 1 :N
                for j = 1:m
                    if(sys_tmp(T,j) == rep_tmp(i,j))
                        meq(i) = meq(i) +1;
                    end
                end
            end


            prob=0;
            for k=1:h-1
                beta = k/N;

                y = zeros(1,m);
                y(1) = p_ini;
                for i = 2:m
                    pl = y(i-1);
                    epl=2 *(1 - eps)* eps+(1 - 2 *eps)^2 *(beta + pl)/(1 + beta) + k * alpha*(1 - 2 *eps)^2 *((1/(k + k*beta)^3)* delta *(1 - 2* eps)^2 *(k^3 *beta^3 + k *pl +3 *k^3 *beta^2 *pl + 3 *(-1 + k)* k *pl^2 + (-2 + k) *(-1 + k)* k *pl^3 + 3 *k *beta *(k *pl - k *pl^2 + k^2 *pl^2)) - (-1 + eps) *eps *delta_n + ((k* beta + k * pl)* (delta + delta* (-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps *delta_n))/(k + k* beta) - (1/(k + k* beta)^2)* (k^2* beta^2 + k * pl + 2 *k^2 *beta *pl - k*pl^2  + k^2 *pl^2)* (2* delta + 4 *delta *(-1 + eps) *eps + delta_l + 4 *(-1 + eps)* eps* delta_n));
                    eq=- pl *(1-epl)+(1-pl)*epl;
                    y(i) = y(i-1) + eq;
                end

                rho = y(m);
                gamma = (1-eps)*rho*pmal+eps*(1-rho*pmal);
                fnk=zeros(N,k+1);
                bi=@(i)((1-det)^meq(i)*det^(m-meq(i)));
                hi=@(i)((1-gamma)^meq(i)*gamma^(m-meq(i)));
                for i=1:N
                    n=N;
                    fnk(i,1)=1;
                    for ii=n-i+1:n
                       fnk(i,1)=fnk(i,1)*hi(i);
                    end

                    for jid=1:min(i,k)
                        j=jid+1;
                        if jid==i
                            for ii=n-i+1:n
                               fnk(i,j)=fnk(i,j)*bi(i);
                            end
                        else
                            fnk(i,j)=bi(i)*fnk(i-1,j-1)+hi(i)*fnk(i-1,j);
                        end
                    end
                end

                prob=prob+fnk(n,k+1);
    %             Ik=combnk(idx,k);
    %             for I=1:size(Ik,1)
    %                 t_prob=1;
    %                 for i = 1:N
    %                     if ismember(i,I)
    %                        t_prob = t_prob * ((1-det)^meq(i)*det^(m-meq(i)));
    %                     else
    %                        t_prob=  t_prob * ((1-gamma)^meq(i)*gamma^(m-meq(i)));
    %                     end
    %                 end
    %                 prob=prob+t_prob;
    %             end




            end


            if(prob > max_prob)
                max_prob = prob;
                max_index = T;
            end
            %prob = 1;
        end
        sys_decision(1,(W-1)*m+1:W*m) = sys_tmp(max_index,:);
    end
    
    
    %sys_decision = sys_tmp(max_index,:);
    for i = 1 : iter
        if(sys_decision(i) == sys_all(i))
            summ = summ + 1;
        else
            i
        end
    end
    true_rate = summ/iter;
    
    
end