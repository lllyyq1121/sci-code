function true_rate = soft_isolation(N,iter,type,eps,beta)
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
    

    Pfa=eps;
    Pd=1-eps;
    Pmal=1;
    Ph0=0.5;
    Ph1=1-Ph0;
    
    eta = 0.2;
    summ = zeros(1,iter);
    dint = zeros(1,iter);
    reputation = zeros(1,N);
    iso = zeros(1,N);
    decision = zeros(1,iter);
    r = zeros(N,iter);
    sum_all = 0;
    true_rate=0;
   
    
    
    %reputation calculate
    %reputation calculate
    for t=1:iter
        for i=1:N
            Pu0=0;Pu1=0;ui=0;Priui=0;
            rk=rep_all(:,t);
            ui=0;%calc ui=0
            if(ui==rk(i))
                Priui=1-beta*Pmal;
            else
                Priui=beta*Pmal;
            end
            PuH0Ph0=Pd*Ph0;
            for j=1:N
                if(i==j) 
                    continue;
                end
                if(rk(j)==0)
                    PuH0Ph0=PuH0Ph0*((1-beta*Pmal)*Pd+beta*Pmal*Pfa);
                else
                    PuH0Ph0=PuH0Ph0*((1-beta*Pmal)*Pfa+beta*Pmal*Pd);
                end
            end
            PuH1P1=Pfa*Ph0;
            for j=1:N
                if(i==j) 
                    continue;
                end
                if(rk(j)==0)
                    PuH1P1=PuH1P1*((1-beta*Pmal)*Pd+beta*Pmal*Pfa);
                else
                    PuH1P1=PuH1P1*((1-beta*Pmal)*Pfa+beta*Pmal*Pd);
                end
            end
            Pu0=Priui*(PuH0Ph0+PuH1P1);
            %%%%%%%%%%%
            ui=1;
            if(ui==rk(i))
                Priui=1-beta*Pmal;
            else
                Priui=beta*Pmal;
            end
            PuH0Ph0=Pfa*Ph0;
            for j=1:N
                if(i==j) 
                    continue;
                end
                if(rk(j)==0)
                    PuH0Ph0=PuH0Ph0*((1-beta*Pmal)*Pd+beta*Pmal*Pfa);
                else
                    PuH0Ph0=PuH0Ph0*((1-beta*Pmal)*Pfa+beta*Pmal*Pd);
                end
            end
            PuH1P1=Pd*Ph0;
            for j=1:N
                if(i==j) 
                    continue;
                end
                if(rk(j)==0)
                    PuH1P1=PuH1P1*((1-beta*Pmal)*Pd+beta*Pmal*Pfa);
                else
                    PuH1P1=PuH1P1*((1-beta*Pmal)*Pfa+beta*Pmal*Pd);
                end
            end
            Pu1=Priui*(PuH0Ph0+PuH1P1);


            r(i,t)=log10(Pu0/Pu1);
            reputation(i) = reputation(i) + r(i,t);
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