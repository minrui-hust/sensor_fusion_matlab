function [x_sample, x_true] = sensor_lidar(x, config)
  %SENSOR_LIDAR given the original true value Pose,
  %return sampled Pose with noise
  %   Detailed explanation goes here

  %% sensor lidar config
  sample_interval = config.sample_interval;

  pos_noise_cov = config.pos_noise_cov;

  rot_noise_cov = config.rot_noise_cov;

  %% resample
  time_min = x.Time(1);
  time_max = x.Time(end);
  sample_time_series = (time_min:sample_interval:time_max)';
  sample = resample(x, sample_time_series);

  position_sample_series = sample.Data(:,1:3);
  quat_sample_series     = sample.Data(:,4:7);


  %% position
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = pos_noise_cov;
  pos_noise_series = mvnrnd(mu,sigma,len);

  %% rotation
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = rot_noise_cov;
  rot_noise_series = mvnrnd(mu,sigma,len);


  %% output
  position_meas_series = position_sample_series + pos_noise_series;
  quat_meas_series = s3_multi(quat_sample_series', s3_exp(rot_noise_series'))';

  x_sample = timeseries([position_meas_series, quat_meas_series], sample_time_series);
  x_true   = timeseries([position_sample_series, quat_sample_series], sample_time_series);
end
