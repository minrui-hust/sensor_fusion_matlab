% IMU
figure('Name', 'Sensor IMU');
subplot(3,2,1);
title('wx');
hold on;
grid on;
plot(imu_gt.Time, imu_gt.Data(:,1), 'b');
plot(imu_sample.Time, imu_sample.Data(:,1), 'r');

subplot(3,2,3);
title('wy');
hold on;
grid on;
plot(imu_gt.Time, imu_gt.Data(:,2), 'b');
plot(imu_sample.Time, imu_sample.Data(:,2), 'r');

subplot(3,2,5);
title('wz');
hold on;
grid on;
plot(imu_gt.Time, imu_gt.Data(:,3), 'b');
plot(imu_sample.Time, imu_sample.Data(:,3), 'r');

subplot(3,2,2);
title('ax');
hold on;
grid on;
plot(imu_gt.Time, imu_gt.Data(:,4), 'b');
plot(imu_sample.Time, imu_sample.Data(:,4), 'r');

subplot(3,2,4);
title('ay');
hold on;
grid on;
plot(imu_gt.Time, imu_gt.Data(:,5), 'b');
plot(imu_sample.Time, imu_sample.Data(:,5), 'r');

subplot(3,2,6);
title('az');
hold on;
grid on;
plot(imu_gt.Time, imu_gt.Data(:,6), 'b');
plot(imu_sample.Time, imu_sample.Data(:,6), 'r');



figure('Name', 'Sensor GPS');
subplot(3,2,1);
title('px');
hold on;
grid on;
plot(gps_gt.Time, gps_gt.Data(:,1), 'b');
plot(gps_sample.Time, gps_sample.Data(:,1), 'r');

subplot(3,2,3);
title('py');
hold on;
grid on;
plot(gps_gt.Time, gps_gt.Data(:,2), 'b');
plot(gps_sample.Time, gps_sample.Data(:,2), 'r');

subplot(3,2,5);
title('pz');
hold on;
grid on;
plot(gps_gt.Time, gps_gt.Data(:,3), 'b');
plot(gps_sample.Time, gps_sample.Data(:,3), 'r');

subplot(3,2,2);
title('vx');
hold on;
grid on;
plot(gps_gt.Time, gps_gt.Data(:,4), 'b');
plot(gps_sample.Time, gps_sample.Data(:,4), 'r');

subplot(3,2,4);
title('vy');
hold on;
grid on;
plot(gps_gt.Time, gps_gt.Data(:,5), 'b');
plot(gps_sample.Time, gps_sample.Data(:,5), 'r');

subplot(3,2,6);
title('vz');
hold on;
grid on;
plot(gps_gt.Time, gps_gt.Data(:,6), 'b');
plot(gps_sample.Time, gps_sample.Data(:,6), 'r');

