% global config
fusion_config.gps_on   = true;
fusion_config.lidar_on = true;
fusion_config.history_win = 20;
fusion_config.state_dimension = 22;
fusion_config.cov_dimension = 21;
fusion_config.noise_dimension = 12;
fusion_config.state_interval= sensor_config.imu.sample_interval;

% predict
fusion_config.predict.history_win = fusion_config.history_win;
fusion_config.predict.state_dimension = fusion_config.state_dimension;
fusion_config.predict.cov_dimension = fusion_config.cov_dimension;
fusion_config.predict.noise_dimension = fusion_config.noise_dimension;
fusion_config.predict.g           = [0;0;-9.8];
fusion_config.predict.sigma_n_w   = diag([0.005 0.005 0.005]);
fusion_config.predict.sigma_n_a   = diag([0.1   0.1  0.1]);
fusion_config.predict.sigma_eta_w = diag([0.00001 0.00001 0.00001]);
fusion_config.predict.sigma_eta_a = diag([0.0001 0.0001 0.0001]);

% gps
fusion_config.gps.history_win = fusion_config.history_win;
fusion_config.gps.state_dimension = fusion_config.state_dimension;
fusion_config.gps.cov_dimension = fusion_config.cov_dimension;
fusion_config.gps.R = diag([0.1 0.1 0.1 , 0.01 0.01 0.01]);

% lidar
fusion_config.lidar.history_win = fusion_config.history_win;
fusion_config.lidar.state_dimension = fusion_config.state_dimension;
fusion_config.lidar.cov_dimension = fusion_config.cov_dimension;
fusion_config.lidar.R = diag([0.01 0.01 0.01 , 0.0003 0.0003 0.0003]);


