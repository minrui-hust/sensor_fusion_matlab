time(1) = seq.time(1);

p_init  = [seq.px(1);seq.py(1);seq.pz(1)];
q_init  = [seq.qw(1);seq.qx(1);seq.qy(1);seq.qz(1)];
v_init  = [seq.vx(1);seq.vy(1);seq.vz(1)];
bw_init = zeros(3,1);%bw_gt.Data(:,1);
ba_init = zeros(3,1);%ba_gt.Data(:,1);
x{1} = [p_init; q_init; v_init; bw_init; ba_init];

p_cov  = [0.00 0.00 0.00];
q_cov  = [0.00 0.00 0.00];
v_cov  = [0.00 0.00 0.00];
bw_cov = [0.00 0.00 0.00];
ba_cov = [0.00 0.00 0.00];
P{1} = diag([p_cov q_cov v_cov bw_cov ba_cov]);

state_id = 1;
