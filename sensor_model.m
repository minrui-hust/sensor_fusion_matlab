%% imu config
imu_config.sample_interval  = 0.002; %second

imu_config.gyro_initial_bias = [0.01 0.01 0.01];  % rad/s
imu_config.gyro_bias_drift_std = 0.01;  % rad/s^2
imu_config.gyro_noise_std = 0.01;  % rad/s

imu_config.acc_initial_bias = [0.01 0.01 0.01];  % m/s^2
imu_config.acc_bias_drift_std = 0.01;  % m/s^3
imu_config.acc_noise_std = 0.01;  % m/s^2


%% compass config
compass_config.sample_interval  = 0.2; %second

compass_config.noise_std = 0.05;  % tesla

compass_config.earth_magnetic = [0 1 0]; % normalized North


%% gps config
gps_config.sample_interval = 0.2; %second

gps_config.horz_pos_noise_std = 0.1; %m
gps_config.vert_pos_noise_std = 0.1; %m

gps_config.horz_vel_noise_std = 0.1; %m/s
gps_config.vert_vel_noise_std = 0.1; %m/s


%% combine all sensor config
sensor_config.imu = imu_config;
sensor_config.compass = compass_config;
sensor_config.gps = gps_config;

