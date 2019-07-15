function x_sample = sensor_imu(x, config)
  %SENSOR_IMU given the original true value of imu, get imu data with noise
  %   Detailed explanation goes here

  %% sensor imu config
  sample_interval = config.sample_interval;

  gyro_initial_bias   = config.gyro_initial_bias;
  gyro_bias_drift_std = config.gyro_bias_drift_std;
  gyro_noise_std     = config.gyro_noise_std;

  acc_initial_bias   = config.acc_initial_bias;
  acc_bias_drift_std = config.acc_bias_drift_std;
  acc_noise_std     = config.acc_noise_std;


  %% resample
  time_min = x.Time(1);
  time_max = x.Time(end);
  sample_time_series = (time_min:sample_interval:time_max)';
  x_sample = resample(x, sample_time_series);


  %% gyro
  % gyro bias
  len = size(sample_time_series,1)-1;
  mu = [0 0 0];
  sigma = [...
    gyro_bias_drift_std^2 0 0;...
    0 gyro_bias_drift_std^2 0;...
    0 0 gyro_bias_drift_std^2;...
    ]*sample_interval;
  gyro_bias_delta_series = mvnrnd(mu,sigma,len);
  gyro_bias_series = cumsum([gyro_initial_bias; gyro_bias_delta_series], 1);

  % gyro noise
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = [...
    gyro_noise_std^2 0 0;...
    0 gyro_noise_std^2 0;...
    0 0 gyro_noise_std^2;...
    ];
  gyro_sample_noise_series = mvnrnd(mu,sigma,len);



  %% acc
  % acc bias
  len = size(sample_time_series,1)-1;
  mu = [0 0 0];
  sigma = [...
    acc_bias_drift_std^2 0 0;...
    0 acc_bias_drift_std^2 0;...
    0 0 acc_bias_drift_std^2;...
    ]*sample_interval;
  acc_bias_delta_series = mvnrnd(mu,sigma,len);
  acc_bias_series = cumsum([acc_initial_bias; acc_bias_delta_series], 1);

  % acc noise
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = [...
    acc_noise_std^2 0 0;...
    0 acc_noise_std^2 0;...
    0 0 acc_noise_std^2;...
    ];
  acc_sample_noise_series = mvnrnd(mu,sigma,len);


  %% output
  x_sample.Data = x_sample.Data + [gyro_bias_series + gyro_sample_noise_series, acc_bias_series + acc_sample_noise_series];
end
