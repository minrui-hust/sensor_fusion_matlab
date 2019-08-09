% IMU
figure('Name', 'Sensor IMU');
subplot(3,2,1);
title('wx');
hold on;
grid on;
plot(imu_sample.Time, imu_sample.Data(:,1), 'r');
plot(imu_gt.Time, imu_gt.Data(:,1), 'b');

subplot(3,2,3);
title('wy');
hold on;
grid on;
plot(imu_sample.Time, imu_sample.Data(:,2), 'r');
plot(imu_gt.Time, imu_gt.Data(:,2), 'b');

subplot(3,2,5);
title('wz');
hold on;
grid on;
plot(imu_sample.Time, imu_sample.Data(:,3), 'r');
plot(imu_gt.Time, imu_gt.Data(:,3), 'b');

subplot(3,2,2);
title('ax');
hold on;
grid on;
plot(imu_sample.Time, imu_sample.Data(:,4), 'r');
plot(imu_gt.Time, imu_gt.Data(:,4), 'b');

subplot(3,2,4);
title('ay');
hold on;
grid on;
plot(imu_sample.Time, imu_sample.Data(:,5), 'r');
plot(imu_gt.Time, imu_gt.Data(:,5), 'b');

subplot(3,2,6);
title('az');
hold on;
grid on;
plot(imu_sample.Time, imu_sample.Data(:,6), 'r');
plot(imu_gt.Time, imu_gt.Data(:,6), 'b');


%GPS
figure('Name', 'Sensor GPS');
subplot(3,2,1);
title('px');
hold on;
grid on;
plot(gps_sample.Time, gps_sample.Data(:,1), 'r');
plot(gps_gt.Time, gps_gt.Data(:,1), 'b');

subplot(3,2,3);
title('py');
hold on;
grid on;
plot(gps_sample.Time, gps_sample.Data(:,2), 'r');
plot(gps_gt.Time, gps_gt.Data(:,2), 'b');

subplot(3,2,5);
title('pz');
hold on;
grid on;
plot(gps_sample.Time, gps_sample.Data(:,3), 'r');
plot(gps_gt.Time, gps_gt.Data(:,3), 'b');

subplot(3,2,2);
title('vx');
hold on;
grid on;
plot(gps_sample.Time, gps_sample.Data(:,4), 'r');
plot(gps_gt.Time, gps_gt.Data(:,4), 'b');

subplot(3,2,4);
title('vy');
hold on;
grid on;
plot(gps_sample.Time, gps_sample.Data(:,5), 'r');
plot(gps_gt.Time, gps_gt.Data(:,5), 'b');

subplot(3,2,6);
title('vz');
hold on;
grid on;
plot(gps_sample.Time, gps_sample.Data(:,6), 'r');
plot(gps_gt.Time, gps_gt.Data(:,6), 'b');


% Lidar
figure('Name', 'Sensor Lidar');
subplot(3,2,1);
title('px');
hold on;
grid on;
plot(lidar_sample.Time, lidar_sample.Data(:,1), 'r');
plot(lidar_gt.Time, lidar_gt.Data(:,1), 'b');

subplot(3,2,3);
title('py');
hold on;
grid on;
plot(lidar_sample.Time, lidar_sample.Data(:,2), 'r');
plot(lidar_gt.Time, lidar_gt.Data(:,2), 'b');

subplot(3,2,5);
title('pz');
hold on;
grid on;
plot(lidar_sample.Time, lidar_sample.Data(:,3), 'r');
plot(lidar_gt.Time, lidar_gt.Data(:,3), 'b');

subplot(3,2,2);
title('qx');
hold on;
grid on;
plot(lidar_sample.Time, lidar_sample.Data(:,5), 'r');
plot(lidar_gt.Time, lidar_gt.Data(:,5), 'b');

subplot(3,2,4);
title('qy');
hold on;
grid on;
plot(lidar_sample.Time, lidar_sample.Data(:,6), 'r');
plot(lidar_gt.Time, lidar_gt.Data(:,6), 'b');

subplot(3,2,6);
title('qz');
hold on;
grid on;
plot(lidar_sample.Time, lidar_sample.Data(:,7), 'r');
plot(lidar_gt.Time, lidar_gt.Data(:,7), 'b');

