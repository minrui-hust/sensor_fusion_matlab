clear all;
addpath ./sequences
addpath ./sensor_model
addpath ./fusion
addpath ./utils

seq = readtable('./sequences/seq1.txt', 'ReadVariableNames', true, 'HeaderLines',0);

seq_timeseries = timeseries([seq.px seq.py seq.pz seq.qw seq.qx seq.qy seq.qz seq.vx seq.vy seq.vz seq.wx seq.wy seq.wz seq.ax seq.ay seq.az], seq.time);

sample_time_series = (seq.time(1):0.005:seq.time(end))';
seq_sample_timeseries = resample(seq_timeseries, sample_time_series);

% time
t = sample_time_series';
dt = diff(t);
len = size(t,2);

% true state
true_p = seq_sample_timeseries.data(:,1:3 )';
true_q = seq_sample_timeseries.data(:,4:7 )';
true_v_local = seq_sample_timeseries.data(:,8:10)';
true_v = quatrotate(quatconj(true_q'), true_v_local')';
true_bw= zeros(3,len);
true_ba= zeros(3,len);
true_x = [true_p;true_q;true_v;true_bw;true_ba];

% input
input_w= seq_sample_timeseries.data(:,11:13)';
input_a= seq_sample_timeseries.data(:,14:16)';% + quatrotate(quatconj(true_q'), [0;0;-9.8]')';
u = [input_w;input_a];

% predect state
predict_x = zeros(3+4+3+3+3, len);
predict_x(:,1) = true_x(:,1);

config.g = [0;0;0];%-9.8];
for i=2:len
  predict_x(:,i) = state_predict(predict_x(:,i-1), u(:,i-1), dt(i-1), config);
end

predict_p =  predict_x(1:3  ,:);
predict_q =  predict_x(4:7  ,:);
predict_v =  predict_x(8:10 ,:);
predict_bw=  predict_x(11:13,:);
predict_ba=  predict_x(14:16,:);


figure('Name', 'quat');
subplot(4,1,1);
title('qw');
grid on;
hold on;
plot(t, true_q(1,:), 'b+');
plot(t, predict_q(1,:), 'rx');

subplot(4,1,2);
title('qx');
grid on;
hold on;
plot(t, true_q(2,:), 'b+');
plot(t, predict_q(2,:), 'rx');

subplot(4,1,3);
title('qy');
grid on;
hold on;
plot(t, true_q(3,:), 'b+');
plot(t, predict_q(3,:), 'rx');

subplot(4,1,4);
title('qz');
grid on;
hold on;
plot(t, true_q(4,:), 'b+');
plot(t, predict_q(4,:), 'rx');



figure('Name', 'v');
subplot(3,1,1);
title('vx');
grid on;
hold on;
plot(t, true_v(1,:), 'b+');
plot(t, predict_v(1,:), 'rx');

subplot(3,1,2);
title('vy');
grid on;
hold on;
plot(t, true_v(2,:), 'b+');
plot(t, predict_v(2,:), 'rx');

subplot(3,1,3);
title('vz');
grid on;
hold on;
plot(t, true_v(3,:), 'b+');
plot(t, predict_v(3,:), 'rx');



figure('Name', 'p');
subplot(3,1,1);
title('px');
grid on;
hold on;
plot(t, true_p(1,:), 'b+');
plot(t, predict_p(1,:), 'rx');

subplot(3,1,2);
title('py');
grid on;
hold on;
plot(t, true_p(2,:), 'b+');
plot(t, predict_p(2,:), 'rx');

subplot(3,1,3);
title('pz');
grid on;
hold on;
plot(t, true_p(3,:), 'b+');
plot(t, predict_p(3,:), 'rx');
