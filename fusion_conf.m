% global config
fusion_config.gps_on   = true;
fusion_config.lidar_on = false;

% predict
fusion_config.predict.g           = [0;0;-9.8];
fusion_config.predict.sigma_n_w   = diag([0.1 0  0 ]);
fusion_config.predict.sigma_n_a   = diag([0 0.2 0.2]);
fusion_config.predict.sigma_eta_w = diag([0 0 0]);
fusion_config.predict.sigma_eta_a = diag([0 0 0]);

% gps
fusion_config.gps.R = diag([1 0.1 0.1 , 1 0.01 0.01]);

