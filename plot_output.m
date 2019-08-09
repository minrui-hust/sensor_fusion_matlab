clear all;

load('stream_gt');
plot_sensor;

res = readtable('./output.txt', 'ReadVariableNames', true, 'HeaderLines',0);

%% generate ground truth at state time
% resample the ground truth at state time
time = res.time';
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
  fusion_p(:,i)  = [res.px(i); res.py(i); res.pz(i)];
  fusion_q(:,i)  = [res.qw(i); res.qx(i); res.qy(i); res.qz(i)];
  fusion_v(:,i)  = [res.vx(i); res.vy(i); res.vz(i)];
  fusion_bw(:,i) = [res.bwx(i); res.bwy(i); res.bwz(i)];
  fusion_ba(:,i) = [res.bax(i); res.bay(i); res.baz(i)];
end

[fusion_yaw, fusion_pitch, fusion_roll] = quat2angle(fusion_q');
fusion_euler = [fusion_roll, fusion_pitch, fusion_yaw]';

plot_fusion;
