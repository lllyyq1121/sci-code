function mean_result = DBsim_meaneps(  g_type , alpha, N ,k,iter, p_ini, b, eps ,beta,pmal)
%    tic
    sim_run_num = 48;
    rand_graph_num = 5;
     graph_all = zeros(N, N, rand_graph_num, 'single');
    result_all = cell(1, rand_graph_num);
    switch g_type  % choose graph type
        case 'regular'  % random regular network
            parfor i = 1:rand_graph_num
                graph_sample = full(createRandRegGraph(N, k));
                graph_all(:, :, i) = random_graph_order(graph_change(graph_sample));
            end
        case 'scale-free'  % scale-free network
            seed = seed_produce(k+1);
            parfor i = 1:rand_graph_num
                graph_sample = sf_gen(N, k/2, seed);
                graph_all(:, :, i) = random_graph_order(graph_change(graph_sample));
            end
        case 'ER'  % random regular network
            parfor i = 1:rand_graph_num
                graph_sample = full(ERRandomGraphGenerate(N, 0.001001));
                graph_all(:, :, i) = random_graph_order(graph_change(graph_sample));
            end
    end
 %   result_all = zeros(sim_run_num, iter, 'single');  % 2-d matrices to record every simulation results
temp2 = zeros(1, iter);
    for i = 1:rand_graph_num
        fprintf('Current running the graph %d / %d\n', i, rand_graph_num);
        graph = graph_all(:, :, i);
        graph_result = cell(1, sim_run_num);
        parfor j = 1: sim_run_num
            graph_result{1, j} = DBsim_eps(alpha,graph,N, iter, p_ini, b,eps,beta,pmal);
        end
        temp = graph_result{1, 1};
        for j = 2:sim_run_num
            temp = temp + graph_result{1, j};
        end
        result_all{1, i} = temp/sim_run_num;
        temp2 = temp2 + result_all{1, i};
    end
    
    mean_result = temp2/rand_graph_num;    
%         parfor j = 1: sim_run_num
%             result_all(j,:) =DBsim_eps(alpha,con_matrix,N, iter, p_ini, b,eps,beta);%DBsim(uff, ufn, unf, unn, graph, alpha, iter, N, p_ini, b);
%         end
%     
% %    mean_graph_result = mean(result_all, 3);  % Expectation calculation w.r.t graph
%     mean_result = mean(result_all); % Expectation calcaulation w.r.t simulation run
%    av_re= sum(mean_result(501:1000))/500;
%    toc
end