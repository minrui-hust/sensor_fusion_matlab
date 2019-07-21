clear all;
addpath ./sequences
addpath ./sensor_model
addpath ./predict
addpath ./meas_model
addpath ./utils/rotation_group

%% load seq
seq = readtable('./sequences/seq1.txt', 'ReadVariableNames', true, 'HeaderLines',0);
gt_raw = timeseries([ seq.px, seq.py, seq.pz, seq.qw, seq.qx, seq.qy, seq.qz, seq.vx, seq.vy, seq.vz, seq.wx, seq.wy, seq.wz, seq.ax, seq.ay, seq.az, seq.mx, seq.my, seq.mz], seq.time);


%% generate sensor data stream
% load sensor model config
sensor_conf;

% get the combined sensor stream
[sensor_stream, imu_sample, imu_gt, gps_sample, gps_gt, lidar_sample, lidar_gt] = sensor_stream(seq, sensor_config);
plot_sensor;


%% ready to fusion
% set fusiont config
fusion_conf

% init the fusion
fusion_init

% loop to process stream
for i=1:size(sensor_stream,2)
  item = sensor_stream{i};

  if strcmp(item.type, 'imu')
    dt = item.time - time(state_id);
    if dt >= 0.005
      [x{state_id+1} P{state_id+1}] = state_predict(x{state_id}, P{state_id}, item.data, dt, fusion_config.predict);
      state_id = state_id + 1;
      time(state_id) = item.time;
      %P{state_id}
    end
  end

  if strcmp(item.type, 'gps') && fusion_config.gps_on
   [x{state_id} P{state_id}] = add_gps_meas(x{state_id}, P{state_id}, item.data, fusion_config.gps.R);
   %P{state_id}
  end

  if strcmp(item.type, 'lidar') && fusion_config.lidar_on
    [x{state_id} P{state_id}] = add_lidar_meas(x{state_id}, P{state_id});
  end

end


%% generate ground truth at state time
% resample the ground truth at state time
gt_resampled = resample(gt_raw, time);
imu_gt_resampled = resample(imu_gt, time);

% split ground truth
gt_p = gt_resampled.Data(:,1:3)';
gt_q = gt_resampled.Data(:,4:7)';
gt_v = gt_resampled.Data(:,8:10)';
gt_w = gt_resampled.Data(:,11:13)';
gt_a = gt_resampled.Data(:,14:16)';
gt_m = gt_resampled.Data(:,17:19)';
gt_bw= imu_gt_resampled.Data(:,7:9)';
gt_ba= imu_gt_resampled.Data(:,10:12)';

[gt_yaw, gt_pitch, gt_roll] = quat2angle(gt_q');
gt_euler = [gt_roll, gt_pitch, gt_yaw]';


%%extract result
len = size(time,2);
for i=1:len
  fusion_p(:,i) = x{i}(1:3,1);
  fusion_q(:,i) = x{i}(4:7,1);
  fusion_v(:,i) = x{i}(8:10,1);
  fusion_bw(:,i) = x{i}(11:13,1);
  fusion_ba(:,i) = x{i}(14:16,1);
end

[fusion_yaw, fusion_pitch, fusion_roll] = quat2angle(fusion_q');
fusion_euler = [fusion_roll, fusion_pitch, fusion_yaw]';


%% plot the result
plot_fusion;
