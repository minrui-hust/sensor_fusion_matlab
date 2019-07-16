function x_sample = sensor_gps(x, config)
  %SENSOR_GPS given the original true value of position and velocity in global frame,
  %return sampled position and velocity with noise
  %   Detailed explanation goes here

  %% sensor gps config
  sample_interval = config.sample_interval;

  horz_pos_noise_std = config.horz_pos_noise_std;
  vert_pos_noise_std = config.vert_pos_noise_std;

  horz_vel_noise_std = config.horz_vel_noise_std;
  vert_vel_noise_std = config.vert_vel_noise_std;

  %% resample
  time_min = x.Time(1);
  time_max = x.Time(end);
  sample_time_series = (time_min:sample_interval:time_max)';
  sample = resample(x, sample_time_series);

  position_sample_series = sample.Data(:,1:3);
  velocity_in_localframe_sample_series = sample.Data(:,4:6);
  quat_sample_series = sample.Data(:,7:10);
  velocity_sample_series = quatrotate(quat_sample_series, velocity_in_localframe_sample_series);


  %% position
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = [...
    horz_pos_noise_std^2 0 0;...
    0 horz_pos_noise_std^2 0;...
    0 0 vert_pos_noise_std^2;...
    ];
  pos_noise_series = mvnrnd(mu,sigma,len);

  %% velocity
  len = size(sample_time_series,1);
  mu = [0 0 0];
  sigma = [...
    horz_vel_noise_std^2 0 0;...
    0 horz_vel_noise_std^2 0;...
    0 0 vert_vel_noise_std^2;...
    ];
  vel_noise_series = mvnrnd(mu,sigma,len);


  %% output
  position_meas_series = position_sample_series + pos_noise_series;
  velocity_meas_series = velocity_sample_series + vel_noise_series;

  x_sample = timeseries([position_meas_series velocity_meas_series], sample_time_series);
end
