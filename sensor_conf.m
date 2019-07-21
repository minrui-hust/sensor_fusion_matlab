%% imu config
sensor_config.imu.sample_interval  = 0.01; %second

sensor_config.imu.gyro_initial_bias = [0; 0; 0];  % rad/s
sensor_config.imu.gyro_bias_drift_cov = diag([0 0 0]);%0.01;  % rad/s^2
sensor_config.imu.gyro_noise_cov = diag([0 0 0]); % rad/s
 
sensor_config.imu.acc_initial_bias = [0; 0; 0]; %[0.01; 0.01; 0.01];  % m/s^2
sensor_config.imu.acc_bias_drift_cov = diag([0 0 0]);%0.01;  % m/s^3
sensor_config.imu.acc_noise_cov = diag([0.1 0 0]);  % m/s^2
sensor_config.imu.earth_gravity = [0;  0; 0]; % m/s^2


%% gps config
sensor_config.gps.sample_interval = 0.2; %second

sensor_config.gps.pos_noise_cov = diag([0.1 0 0]); %m

sensor_config.gps.vel_noise_cov = diag([0.01 0.0 0.0]); %m/s


%% lidar config
sensor_config.lidar.sample_interval = 0.1; %second

sensor_config.lidar.horz_pos_noise_std = 0.1; %m
sensor_config.lidar.vert_pos_noise_std = 0.1; %m

sensor_config.lidar.horz_rot_noise_std = 0.02; % rad
sensor_config.lidar.vert_rot_noise_std = 0.02; % rad


%% compass config
sensor_config.compass.sample_interval  = 0.2; %second

sensor_config.compass.noise_std = 0.05;  % tesla

sensor_config.compass.earth_magnetic = [0; 1; 0]; % normalized North

