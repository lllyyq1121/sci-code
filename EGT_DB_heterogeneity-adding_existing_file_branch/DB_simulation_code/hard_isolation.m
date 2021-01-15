function true_rate = hard_isolation(N,iter,type)
 %   N = 100;
    Nint = N;
 %   iter = 200;
    load('./fusion_data/sys.mat')
    load('./fusion_data/obv.mat')
    load('./fusion_data/rep.mat')
    load('./fusion_data/action.mat')
    load('./fusion_data/nodes.mat')
    load('./fusion_data/repnoin.mat')
    if(type == 1)
        rep_all = rep_noin;
    end
    
    eta = 0.2;
    summ = zeros(1,iter);
    dint = zeros(1,iter);
    reputation = zeros(1,N);
    iso = zeros(1,N);
    decision = zeros(1,iter);
    sum_all = 0;
    true_rate=0;
    
    %dint calculate
    for i = 1:iter
        summ(i) = sum(rep_all(:,i));
         if(summ(i) >= N/2)
                dint(i) = 1;
         end
    end
    
    %reputation calculate
    for i = 1:N
        for j = 1:iter
            if( rep_all(i,j) == dint(j))
                reputation(i) = reputation(i)+1;
            end
        end
    end
    
    %isolation
    so = reputation;
    so = sort(so);
    et = so(eta*N);
    for i = 1:N
        if(reputation(i) < et)
            iso(i) = 1;
            Nint = Nint - 1;
        end
    end
    
    %final fusion
    summ = zeros(1,iter);
    for i = 1:iter
        
        for j = 1:N
            if(iso(j) == 0)
                summ(i) = summ(i)+rep_all(j,i);
            end
        end
        if(summ(i) >= round(Nint/2))
            decision(i) = 1;
        end
        
    end
    
    %true rate
    for i = 1:iter
        if(decision(i) == sys_all(i))
            sum_all = sum_all +1;
        end
    end
    true_rate = sum_all / iter;
    
    
end