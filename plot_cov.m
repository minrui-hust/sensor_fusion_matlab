%% plot v-cv

for i=1:size(time,2)
  vx_cov(:,i) = P{i}(7,7);
  roll_cov(:,i) = P{i}(4,4);
end

figure('Name', 'roll-cov');

subplot(2,1,1);
title('roll-cov');
grid on;
hold on;
plot(time, roll_cov, 'r');

subplot(2,1,2);
title('vx-cov');
grid on;
hold on;
plot(time, vx_cov, 'r');

