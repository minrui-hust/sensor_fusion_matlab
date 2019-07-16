clear all;
addpath ./sequences
addpath ./sensor_model

seq = readtable('./sequences/seq1.txt', 'ReadVariableNames', true, 'HeaderLines',0);

imu = timeseries([seq.wx seq.wy seq.wz seq.ax seq.ay seq.az seq.qw seq.qx seq.qy seq.qz], seq.time);
gps = timeseries([seq.px seq.py seq.pz seq.vx seq.vy seq.vz seq.qw seq.qx seq.qy seq.qz], seq.time);
quat = timeseries([seq.qw seq.qx seq.wy seq.qz], seq.time);
lidar= timeseries([seq.px seq.py seq.pz seq.qw seq.qx seq.qy seq.qz], seq.time);

sensor_model;
imu_sampled = sensor_imu(imu, sensor_config.imu);
gps_sampled = sensor_gps(gps, sensor_config.gps);
compass_sampled = sensor_compass(quat, sensor_config.compass);
lidar_sampled = sensor_lidar(lidar, sensor_config.lidar);

figure('Name', 'imu');
subplot(1,2,1);
title('wx');
hold on;
grid on;
plot(imu.Time, imu.Data(:,1), 'g');
plot(imu_sampled.Time, imu_sampled.Data(:,1), 'r');

subplot(1,2,2);
title('ax');
hold on;
grid on;
plot(imu.Time, imu.Data(:,4), 'g');
plot(imu_sampled.Time, imu_sampled.Data(:,4), 'r');


figure('Name', 'gps');
subplot(1,2,1);
title('px');
hold on;
grid on;
plot(gps.Time, gps.Data(:,1), 'g');
plot(gps_sampled.Time, gps_sampled.Data(:,1), 'r');

subplot(1,2,2);
title('vx');
hold on;
grid on;
plot(gps.Time, gps.Data(:,4), 'g');
plot(gps_sampled.Time, gps_sampled.Data(:,4), 'r');


figure('Name', 'compass');
title('magx');
hold on;
grid on;
plot(compass_sampled.Time, compass_sampled.Data(:,1), 'r');

figure('Name', 'lidar');
title('quat.w');
hold on;
grid on;
plot(lidar.Time, lidar.Data(:,1), 'g');
plot(lidar_sampled.Time, lidar_sampled.Data(:,1), 'r');

