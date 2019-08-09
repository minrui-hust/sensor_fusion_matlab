%% imu config
sensor_config.imu.sample_interval  = 0.01; %second

sensor_config.imu.gyro_initial_bias = [0; 0; 0];  % rad/s
sensor_config.imu.gyro_bias_drift_cov = diag([0.00001 0.00001 0.00001]);%0.01;  % rad/s^2
sensor_config.imu.gyro_noise_cov = diag([0.005 0.005 0.005]); % rad/s
 
sensor_config.imu.acc_initial_bias = [0; 0; 0]; %[0.01; 0.01; 0.01];  % m/s^2
sensor_config.imu.acc_bias_drift_cov = diag([0.0001 0.0001 0.0001]);%0.01;  % m/s^3
sensor_config.imu.acc_noise_cov = diag([0.1 0.1 0.1]);  % m/s^2
sensor_config.imu.earth_gravity = [0;  0; -9.8]; % m/s^2


%% gps config
sensor_config.gps.delay = 0.05;

sensor_config.gps.sample_interval = 0.2; %second

sensor_config.gps.t_imu_gps = [0;0;0];

sensor_config.gps.pos_noise_cov = diag([0.1 0.1 0.1]); %m

sensor_config.gps.vel_noise_cov = diag([0.01 0.01 0.01]); %m/s


%% lidar config
sensor_config.lidar.delay = 0.1;

sensor_config.lidar.sample_interval = 0.1; %second

sensor_config.lidar.t_imu_lidar = [0;0;0];

sensor_config.lidar.q_imu_lidar = [1;0;0;0];

sensor_config.lidar.pos_noise_cov = diag([0.01 0.01 0.01]); %m

sensor_config.lidar.rot_noise_cov = diag([0.0003 0.0003 0.0003]); % rad


