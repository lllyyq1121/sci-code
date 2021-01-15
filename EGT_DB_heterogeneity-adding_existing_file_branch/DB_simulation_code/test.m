rate = 0;
for i = 1:1000
x=DBsim_eps_fusion2(0.0001,graph, 20,6, 0.2, 1,0.4,0.5);
true_rate=map_fusion_new(20,6,0,0.4,0.5,mean(x))
rate = rate+true_rate;
end
rate = rate/1000;