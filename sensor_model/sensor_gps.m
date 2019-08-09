function [x_sample, x_true] = sensor_gps(x, config)
  %SENSOR_GPS given the original true value of position and velocity in global frame,
  %return sampled position and velocity with noise
  %   Detailed explanation goes here

  %% sensor gps config
  sample_interval = config.sample_interval;

  t_imu_gps = config.t_imu_gps;

  pos_noise_cov = config.pos_noise_cov;

  vel_noise_cov = config.vel_noise_cov;

  %% resample
  time_min = x.Time(1);
  time_max = x.Time(end);
  sample_time_series = (time_min:sample_interval:time_max)';
  sample = resample(x, sample_time_series);

  %% convert data in imu frame to gps frame
  imu_position_sample_series = sample.Data(:,1:3);
  imu_quat_sample_series = sample.Data(:,4:7);
  imu_velocity_sample_series = sample.Data(:,8:10);
  imu_omega_sample_series = sample.Data(:,11:13);

  position_sample_series = s3_rotate(imu_quat_sample_series', t_imu_gps)' + imu_position_sample_series;
  velocity_sample_series = imu_velocity_sample_series - s3_rotate(imu_quat_sample_series', so3_hat(t_imu_gps)*imu_omega_sample_series')';

  %% position noise
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = pos_noise_cov;
  pos_noise_series = mvnrnd(mu,sigma,len);

  %% velocity noise
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = vel_noise_cov;
  vel_noise_series = mvnrnd(mu,sigma,len);


  %% output
  position_meas_series = position_sample_series + pos_noise_series;
  velocity_meas_series = velocity_sample_series + vel_noise_series;

  x_sample = timeseries([position_meas_series, velocity_meas_series], sample_time_series);
  x_true = timeseries([position_sample_series, velocity_sample_series], sample_time_series);
end
