function result = DBsim_eps_fusion2(alpha,con_matrix, N,iter, p_ini, b,eps,beta)
% The most orginal simulation code for DB update rule
% complete graph

% =========================
% inputs
% pm: a struct variable representing payoff matrix value
% con_matrix: adjacency list of the given network structure
% alpha: the selection intensity
% iter: iteration numbers
% N: total user number
% p_ini: the initial percentage of Sf adopters
% b: baseline fitness of all users
% -------------------------
% outputs
% result: 1*iter vector, the simulation results
% =========================

%     uls = pm.uff;
%     uld = pm.ufn;
%     uns = pm.unf;
%     und = pm.unn;
    uls = 0.6;
    uld = 0.4;
    uns = 0.8;
    und = 0.6;

    


    %initiliation nodes
%    N = 1000;
    num_h = round(N/(1+beta)) ;
    num_b = N- num_h;%    N = num_b+num_h;
    index_b = (num_h +1)  : N;
%    index_h = 1:num_h;   
    
    action_table = zeros(1, N);
    nodes_all = zeros(1,N);
    result = zeros(1, iter);  % result is xf of users
    sys_all = zeros(1,iter);
    obv_all = zeros(N,iter);
    rep_all = zeros(N,iter);
    action_all = zeros(N,iter);
    nodes_all(index_b) = 1;
    rep_noin = zeros(N,iter);
    
    degree_table = single(sum(con_matrix ~= 0, 2).');  % calculate degree of each nodes
    
    % strategy Initialization
    ini_user = randperm(num_h, round(num_h * p_ini));
    action_table(ini_user) = 1;
    action_table(index_b) = 1;

    
 
    %systerm state Initialization
    sys = round(rand(1)) * ones(1,N);
    obv = sys ;
    for i = 1:N
        if( rand < eps)
            obv(i) = ~sys(i);
        end
    end
    rep = obv ;
    rep(ini_user) = ~obv(ini_user);
    rep(index_b) = ~obv(index_b);
    repnoin(index_b) = ~obv(index_b);
    rep_noin(:,1) = repnoin;
    
    sys_all(1)=sys(1);
    obv_all(:,1)=obv;
    rep_all(:,1)=rep;
    action_all(:,1) = action_table;
    
    baseline_table = b * ones(1, N);
    fit_table = zeros(1, N);  % fit_table: recording each user's fitness.
    for i = 1:N
        neigh_list = con_matrix(i, 1:degree_table(i));
        str_neigh = action_table(neigh_list);
        s1_neigh_num = sum(str_neigh); % count how many neighbors use sf
%        s1_neigh_num = sum(rep);
        s0_neigh_num = degree_table(i) - s1_neigh_num;
        if(action_table(i) == 0)
            if(rep(i))
                fit_table(i) = (1-alpha) * baseline_table(i) + alpha *  (uns * (s1_neigh_num - 1) + und * s0_neigh_num);
            else
                fit_table(i) = (1-alpha) * baseline_table(i) + alpha *  (uns * (s0_neigh_num - 1) + und * s1_neigh_num);
            end
        else
            if(rep(i))
                fit_table(i) = (1-alpha) * baseline_table(i) + alpha *  (uls * (s1_neigh_num - 1) + uld * s0_neigh_num);
            else
                fit_table(i) = (1-alpha) * baseline_table(i) + alpha * (uls * (s0_neigh_num - 1) + uld * s1_neigh_num);
            end
        end
    end

    
    
%     for i = 1:N
%         neigh_list = con_matrix(i, 1:degree_table(i));
%         str_neigh = action_table(neigh_list);
%         sf_neigh_num = sum(str_neigh); % count how many neighbors use sf
%         if action_table (i)
%             fit_table(i) = baseline_table(i) + sf_neigh_num * uff + (degree_table(i) - sf_neigh_num) * ufn;
%         else
%             fit_table(i) = baseline_table(i) + sf_neigh_num * unf + (degree_table(i) - sf_neigh_num) * unn;
%         end
%     end
    
    count = 1;
    result(count) = (sum(action_table )- num_b)/(N - num_b);
    count = count + 1;
    
    % begin DB update rule
    while count <= iter
        for p = 1:num_h
            i = randi(num_h);  % pick a central user
            
            friend_number = degree_table(i);  % find friends
            friend_list = con_matrix(i, 1:friend_number);
%
            fit_f = 0;
            fit_n = 0;
            
            for j = friend_list
                if (rep(j) ~= obv(i))
                    fit_f = fit_f + fit_table(j);
                else
                    fit_n = fit_n + fit_table(j);
                end
            end
  
                
            if action_table(i) == 1  % strategy update
                judge = fit_n/(fit_f + fit_n);
                if rand <= judge
                    action_table(i) = 0;
                    rep(i) ~= rep(i);
                end
            else
                judge = fit_f/(fit_f + fit_n);
                if rand <= judge
                    action_table(i) = 1;
                    rep(i) ~= rep(i);
                end
            end
        
        
        end
        
        result(count) = (sum(action_table)-num_b)/(N-num_b);

        
        %systerm update
        sys = round(rand(1)) * ones(1,N);
        obv = sys ;
        for i = 1:N
            if(rand < eps)
                obv(i) = ~sys(i);
            end
        end

        rep = obv ;
        rep(action_table==1) = ~obv(action_table==1);
        repnoin = obv;
        repnoin(index_b) = ~obv(index_b);
        rep_noin(:,count) = repnoin;
        sys_all(count)=sys(1);
        obv_all(:,count)=obv;
        rep_all(:,count)=rep;
        action_all(:,count) = action_table;
        %fitness update

        for i = 1:N
       s1_neigh_num = sum(str_neigh); % count how many neighbors use sf
%        s1_neigh_num = sum(rep);
        s0_neigh_num = degree_table(i) - s1_neigh_num;          
            if(action_table(i) == 0)
                if(rep(i))
                    fit_table(i) = (1-alpha) * baseline_table(i) + alpha * (uns * (s1_neigh_num - 1) + und * s0_neigh_num);
                else
                    fit_table(i) = (1-alpha) * baseline_table(i) + alpha * (uns * (s0_neigh_num - 1) + und * s1_neigh_num);
                end
            else
                if(rep(i))
                    fit_table(i) = (1-alpha) * baseline_table(i) +  alpha * (uls * (s1_neigh_num - 1) + uld * s0_neigh_num);
                else
                    fit_table(i) = (1-alpha) * baseline_table(i) +  alpha * (uls * (s0_neigh_num - 1) + uld * s1_neigh_num);
                end
            end
        end 
                count = count + 1;
    end
     save('./fusion_data/sys.mat','sys_all')
    save('./fusion_data/obv.mat','obv_all')
    save('./fusion_data/rep.mat','rep_all')
    save('./fusion_data/action.mat','action_all')
    save('./fusion_data/nodes.mat','nodes_all')
    save('./fusion_data/repnoin.mat','rep_noin')   
end