% plot quat
figure('Name', 'quat');

subplot(3,2,1);
title('qx');
grid on;
hold on;
plot(time, fusion_q(2,:), 'r');
plot(time, gt_q(2,:), 'b');

subplot(3,2,3);
title('qy');
grid on;
hold on;
plot(time, fusion_q(3,:), 'r');
plot(time, gt_q(3,:), 'b');

subplot(3,2,5);
title('qz');
grid on;
hold on;
plot(time, fusion_q(4,:), 'r');
plot(time, gt_q(4,:), 'b');

subplot(3,2,2);
title('roll');
grid on;
hold on;
plot(time, fusion_euler(1,:), 'r');
plot(time, gt_euler(1,:), 'b');

subplot(3,2,4);
title('pitch');
grid on;
hold on;
plot(time, fusion_euler(2,:), 'r');
plot(time, gt_euler(2,:), 'b');

subplot(3,2,6);
title('yaw');
grid on;
hold on;
plot(time, fusion_euler(3,:), 'r');
plot(time, gt_euler(3,:), 'b');


%% plot IMU bias
figure('Name', 'bias');

subplot(3,2,1);
title('bw-x');
grid on;
hold on;
plot(time, fusion_bw(1,:), 'r');
plot(time, gt_bw(1,:), 'b');

subplot(3,2,3);
title('bw-y');
grid on;
hold on;
plot(time, fusion_bw(2,:), 'r');
plot(time, gt_bw(2,:), 'b');

subplot(3,2,5);
title('bw-z');
grid on;
hold on;
plot(time, fusion_bw(3,:), 'r');
plot(time, gt_bw(3,:), 'b');

subplot(3,2,2);
title('ba-x');
grid on;
hold on;
plot(time, fusion_ba(1,:), 'r');
plot(time, gt_ba(1,:), 'b');

subplot(3,2,4);
title('ba-y');
grid on;
hold on;
plot(time, fusion_ba(2,:), 'r');
plot(time, gt_ba(2,:), 'b');

subplot(3,2,6);
title('ba-z');
grid on;
hold on;
plot(time, fusion_ba(3,:), 'r');
plot(time, gt_ba(3,:), 'b');


%% plot pva
figure('Name', 'pva');

subplot(3,3,1);
title('px');
grid on;
hold on;
plot(time, fusion_p(1,:), 'r');
plot(time, gt_p(1,:), 'b');

subplot(3,3,4);
title('py');
grid on;
hold on;
plot(time, fusion_p(2,:), 'r');
plot(time, gt_p(2,:), 'b');

subplot(3,3,7);
title('pz');
grid on;
hold on;
plot(time, fusion_p(3,:), 'r');
plot(time, gt_p(3,:), 'b');


subplot(3,3,2);
title('vx');
grid on;
hold on;
plot(time, fusion_v(1,:), 'r');
plot(time, gt_v(1,:), 'b');

subplot(3,3,5);
title('vy');
grid on;
hold on;
plot(time, fusion_v(2,:), 'r');
plot(time, gt_v(2,:), 'b');

subplot(3,3,8);
title('vz');
grid on;
hold on;
plot(time, fusion_v(3,:), 'r');
plot(time, gt_v(3,:), 'b');

subplot(3,3,3);
title('ax');
grid on;
hold on;
plot(time, fusion_a(1,:), 'r');
plot(time, gt_a(1,:), 'b');

subplot(3,3,6);
title('ay');
grid on;
hold on;
plot(time, fusion_a(2,:), 'r');
plot(time, gt_a(2,:), 'b');

subplot(3,3,9);
title('az');
grid on;
hold on;
plot(time, fusion_a(3,:), 'r');
plot(time, gt_a(3,:), 'b');

