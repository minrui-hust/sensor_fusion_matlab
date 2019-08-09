clear all;
addpath ./sequences
addpath ./sensor_model
addpath ./predict
addpath ./meas_model
addpath ./utils/rotation_group

%% load seq
seq = readtable('./sequences/seq3.txt', 'ReadVariableNames', true, 'HeaderLines',0);
gt_raw = timeseries([ seq.px, seq.py, seq.pz, seq.qw, seq.qx, seq.qy, seq.qz, seq.vx, seq.vy, seq.vz, seq.wx, seq.wy, seq.wz, seq.ax, seq.ay, seq.az, seq.mx, seq.my, seq.mz], seq.time);

%% generate sensor data stream
% load sensor model config
sensor_conf;

% get the combined sensor stream
[stream, imu_sample, imu_gt, gps_sample, gps_gt, lidar_sample, lidar_gt] = sensor_stream(seq, sensor_config);
% plot_sensor;

%save the snapshot of the ground truth and sensor data
save('stream_gt');

p_init  = [seq.px(1);seq.py(1);seq.pz(1)];
q_init  = [seq.qw(1);seq.qx(1);seq.qy(1);seq.qz(1)];
v_init  = [seq.vx(1);seq.vy(1);seq.vz(1)];
w_init  = imu_gt.Data(1,1:3)';
a_init  = s3_rotate(q_init, imu_gt.Data(1,4:6)') - sensor_config.imu.earth_gravity;
bw_init = imu_gt.Data(1,7 :9 )';
ba_init = imu_gt.Data(1,10:12)';
time_init = seq.time(1);

fid = fopen('stream.txt','w+');
fprintf(fid, 'gt %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f %25.15f\n',...
  [time_init; p_init;q_init;v_init;w_init;a_init;bw_init;ba_init]);

for i=1:size(stream,2)
  item = stream{i};
  fprintf(fid, '%s %25.15f', item.type, item.time);
  for j=1:size(item.data,1)
    fprintf(fid, ' %25.15f', item.data(j));
  end
  fprintf(fid, '\n');
end

fclose(fid);
