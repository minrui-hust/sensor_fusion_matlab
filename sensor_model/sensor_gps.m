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
  x_sample = resample(x, sample_time_series);

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
  x_sample.Data = x_sample.Data + [pos_noise_series vel_noise_series];
end
