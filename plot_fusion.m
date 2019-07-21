% plot quat
figure('Name', 'quat');

subplot(3,2,1);
title('qx');
grid on;
hold on;
plot(time, gt_q(2,:), 'b');
plot(time, fusion_q(2,:), 'r');

subplot(3,2,3);
title('qy');
grid on;
hold on;
plot(time, gt_q(3,:), 'b');
plot(time, fusion_q(3,:), 'r');

subplot(3,2,5);
title('qz');
grid on;
hold on;
plot(time, gt_q(4,:), 'b');
plot(time, fusion_q(4,:), 'r');

subplot(3,2,2);
title('roll');
grid on;
hold on;
plot(time, gt_euler(1,:), 'b');
plot(time, fusion_euler(1,:), 'r');

subplot(3,2,4);
title('pitch');
grid on;
hold on;
plot(time, gt_euler(2,:), 'b');
plot(time, fusion_euler(2,:), 'r');

subplot(3,2,6);
title('yaw');
grid on;
hold on;
plot(time, gt_euler(3,:), 'b');
plot(time, fusion_euler(3,:), 'r');


%% plot v
figure('Name', 'v');
subplot(3,1,1);
title('vx');
grid on;
hold on;
plot(time, gt_v(1,:), 'b');
plot(time, fusion_v(1,:), 'r');

subplot(3,1,2);
title('vy');
grid on;
hold on;
plot(time, gt_v(2,:), 'b');
plot(time, fusion_v(2,:), 'r');

subplot(3,1,3);
title('vz');
grid on;
hold on;
plot(time, gt_v(3,:), 'b');
plot(time, fusion_v(3,:), 'r');


%% plot p
%figure('Name', 'p');
%subplot(3,1,1);
%title('px');
%grid on;
%hold on;
%plot(gt_p.Time, gt_p.Data(1,:), 'b+');
%plot(time, fusion_p(1,:), 'rx');
%
%subplot(3,1,2);
%title('py');
%grid on;
%hold on;
%plot(gt_p.Time, gt_p.Data(2,:), 'b+');
%plot(time, fusion_p(2,:), 'rx');
%
%subplot(3,1,3);
%title('pz');
%grid on;
%hold on;
%plot(gt_p.Time, gt_p.Data(3,:), 'b+');
%plot(time, fusion_p(3,:), 'rx');
%
