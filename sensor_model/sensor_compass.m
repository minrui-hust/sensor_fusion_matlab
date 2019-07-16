function x_sample = sensor_compass(x, config)
  %SENSOR_IMU given the original true value of rotation, get compass data with noise
  %   Detailed explanation goes here

  %% sensor compass config
  sample_interval = config.sample_interval;

  noise_std = config.noise_std;

  earth_magnetic = config.earth_magnetic;


  %% resample
  time_min = x.Time(1);
  time_max = x.Time(end);
  sample_time_series = (time_min:sample_interval:time_max)';
  sample = resample(x, sample_time_series);

  sampled_quat_series = sample.Data(:,1:4);
  sampled_magnetic_series = quatrotate(quatconj(sampled_quat_series), earth_magnetic);


  %% noise
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = [...
    noise_std^2 0 0;...
    0 noise_std^2 0;...
    0 0 noise_std^2;...
    ];
  noise_series = mvnrnd(mu,sigma,len);


  %% output
  x_sample = timeseries(sampled_magnetic_series + noise_series, sample_time_series);
end
