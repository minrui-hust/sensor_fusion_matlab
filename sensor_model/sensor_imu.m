function [x_sample, x_true] = sensor_imu(x, config)
  %SENSOR_IMU given the original true value of imu, get imu data with noise
  %   Detailed explanation goes here

  %% sensor imu config
  sample_interval = config.sample_interval;

  gyro_initial_bias   = config.gyro_initial_bias;
  gyro_bias_drift_cov = config.gyro_bias_drift_cov;
  gyro_noise_cov      = config.gyro_noise_cov;

  acc_initial_bias   = config.acc_initial_bias;
  acc_bias_drift_cov = config.acc_bias_drift_cov;
  acc_noise_cov     = config.acc_noise_cov;

  earth_gravity     = config.earth_gravity;


  %% resample
  time_min = x.Time(1);
  time_max = x.Time(end);
  sample_time_series = (time_min:sample_interval:time_max)';
  sample = resample(x, sample_time_series);

  gyro_sampled_series = sample.Data(:,1:3 );
  acc_sampled_series  = sample.Data(:,4:6 );
  quat_sampled_series = sample.Data(:,7:10);


  %% gyro
  % gyro bias
  len = size(sample_time_series,1)-1;
  mu = [0 0 0];
  sigma = gyro_bias_drift_cov * sample_interval;
  gyro_bias_delta_series = mvnrnd(mu,sigma,len);
  gyro_bias_series = cumsum([gyro_initial_bias'; gyro_bias_delta_series], 1);

  % gyro noise
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = gyro_noise_cov;
  gyro_sample_noise_series = mvnrnd(mu,sigma,len);


  %% acc
  % acc bias
  len = size(sample_time_series,1)-1;
  mu = [0 0 0];
  sigma = acc_bias_drift_cov*sample_interval;
  acc_bias_delta_series = mvnrnd(mu,sigma,len);
  acc_bias_series = cumsum([acc_initial_bias'; acc_bias_delta_series], 1);

  % acc noise
  len = size(sample_time_series,2);
  mu = [0; 0; 0];
  sigma = acc_noise_cov;
  acc_sample_noise_series = mvnrnd(mu,sigma,len);

  % convert gravity in global frame to local frame
  gravity_in_local_series = (s3_rotate(s3_conj(quat_sampled_series'), earth_gravity))';


  %% output
  gyro_meas_series = gyro_sampled_series + gyro_bias_series + gyro_sample_noise_series;
  acc_meas_series = acc_sampled_series + gravity_in_local_series + acc_bias_series + acc_sample_noise_series;

  x_sample = timeseries([gyro_meas_series, acc_meas_series], sample_time_series);
  x_true =  timeseries([gyro_sampled_series,acc_sampled_series+gravity_in_local_series,gyro_bias_series,acc_bias_series ], sample_time_series);
end
