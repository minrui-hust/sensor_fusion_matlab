state_id = 1;

time(state_id) = seq.time(1);
history_time{state_id} = repmat(time(state_id), fusion_config.history_win, 1);

p_init  = [seq.px(1);seq.py(1);seq.pz(1)];
q_init  = [seq.qw(1);seq.qx(1);seq.qy(1);seq.qz(1)];
v_init  = [seq.vx(1);seq.vy(1);seq.vz(1)];
w_init  = imu_gt.Data(1,1:3)';
a_init  = s3_rotate(q_init, imu_gt.Data(1,4:6)') - sensor_config.imu.earth_gravity;
bw_init = imu_gt.Data(1,7:9)';
ba_init = imu_gt.Data(1,10:12)';
x{state_id} = repmat([p_init; q_init; v_init; w_init; a_init; bw_init; ba_init], fusion_config.history_win,1);

p_cov  = [0.00 0.00 0.00];
q_cov  = [0.00 0.00 0.00];
v_cov  = [0.00 0.00 0.00];
w_cov  = [0.00 0.00 0.00];
a_cov  = [0.00 0.00 0.00];
bw_cov = [0.00 0.00 0.00];
ba_cov = [0.00 0.00 0.00];
P{state_id} = diag(repmat([p_cov q_cov v_cov w_cov a_cov bw_cov ba_cov],1,fusion_config.history_win));
