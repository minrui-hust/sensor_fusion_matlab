function [xx_predict PP_predict] = state_predict(xx, PP, u, dt, config)
  %Give current state and input, return predict next state

  % config
  g = config.g;
  win = config.history_win;
  state_dem = config.state_dimension;
  cov_dem = config.cov_dimension;
  noise_dem = config.noise_dimension;
  sigma_n_w = config.sigma_n_w;
  sigma_n_a = config.sigma_n_a;
  sigma_eta_w = config.sigma_eta_w;
  sigma_eta_a = config.sigma_eta_a;

  % split the state
  p = xx(1:3);
  q = xx(4:7);
  v = xx(8:10);
  w = xx(11:13);
  a = xx(14:16);
  bw= xx(17:19);
  ba= xx(20:22);

  % split the input
  w_meas = u(1:3);
  a_meas = u(4:6);

  % predict the state
  w_predict = w_meas - bw;
  q_predict = s3_multi(q, s3_exp((w + w_predict)/2*dt));
  a_predict = s3Tso3(q_predict)*(a_meas - ba) - g;
  v_predict = v + a*dt;
  p_predict = p + v*dt;
  bw_predict = bw;
  ba_predict = ba;

  x_predict = [p_predict; q_predict; v_predict; w_predict; a_predict; bw_predict; ba_predict];

  xx_predict = [x_predict; xx(1:(win-1)*state_dem,1)];

  % calc the state transit matrix
  J_p_p = eye(3,3);
  J_p_v = eye(3,3)*dt;
  J_q_q = so3_exp((w+w_predict)/2*dt)';%so3_exp(w*dt)'; %so3_exp((w+w_predict)/2*dt)';
  J_q_w = 1/2*rjac((w+w_predict)/2*dt) * dt;%rjac(w*dt) * dt; %1/2*rjac((w+w_predict)/2*dt) * dt;
  J_q_bw = -1/2*rjac((w+w_predict)/2*dt) * dt;%zeros(3,3);% -1/2*rjac((w+w_predict)/2*dt) * dt;
  J_v_v = eye(3,3);
  J_v_a = eye(3,3)*dt; 
  J_w_bw = -eye(3,3); 
  J_a_q = -s3Tso3(q_predict) * so3_hat(a_meas - ba) * J_q_q;
  J_a_w = -s3Tso3(q_predict) * so3_hat(a_meas - ba) * J_q_w; 
  J_a_bw = -s3Tso3(q_predict) * so3_hat(a_meas - ba) * J_q_bw; 
  J_a_ba = -s3Tso3(q_predict); 
  J_bw_bw = eye(3,3);
  J_ba_ba = eye(3,3);

  A = [...
    J_p_p zeros(3,3) J_p_v zeros(3,3) zeros(3,3) zeros(3,3) zeros(3,3);...
    zeros(3,3) J_q_q zeros(3,3) J_q_w zeros(3,3) J_q_bw zeros(3,3);...
    zeros(3,3) zeros(3,3) J_v_v zeros(3,3) J_v_a zeros(3,3) zeros(3,3);...
    zeros(3,3) zeros(3,3) zeros(3,3) zeros(3,3) zeros(3,3) J_w_bw zeros(3,3);...
    zeros(3,3) J_a_q zeros(3,3) J_a_w zeros(3,3) zeros(3,3) J_a_ba;...
    zeros(3,3) zeros(3,3) zeros(3,3) zeros(3,3) zeros(3,3) J_bw_bw zeros(3,3);...
    zeros(3,3) zeros(3,3) zeros(3,3) zeros(3,3) zeros(3,3) zeros(3,3) J_ba_ba;...
    ];
  
  % augmented state transition matrix
  AA = [...
                  A                            zeros(cov_dem, (win-1)*cov_dem);...
    eye((win-1)*cov_dem, (win-1)*cov_dem)  zeros((win-1)*cov_dem, cov_dem);...
    ];

  
  % calc the noise transit matrix
  J_q_nw = J_q_bw;%zeros(3,3); %J_q_bw;
  J_q_etaw = J_q_bw*dt;%zeros(3,3); %J_q_bw*dt;
  J_w_nw = -eye(3,3);
  J_w_etaw = -eye(3,3)*dt;
  J_a_nw = J_a_bw;
  J_a_na = -s3Tso3(q_predict);
  J_a_etaw = J_a_nw*dt;
  J_a_etaa = J_a_na*dt;
  J_bw_etaw = eye(3,3)*dt;
  J_ba_etaa = eye(3,3)*dt;

  L = [...
    zeros(3,3)  zeros(3,3) zeros(3,3)  zeros(3,3);...
    J_q_nw  zeros(3,3) J_q_etaw  zeros(3,3);...
    zeros(3,3)  zeros(3,3) zeros(3,3)  zeros(3,3);...
    J_w_nw zeros(3,3) J_w_etaw zeros(3,3);...
    zeros(3,3) J_a_na zeros(3,3) J_a_etaa;...
    zeros(3,3) zeros(3,3) J_bw_etaw zeros(3,3);...
    zeros(3,3) zeros(3,3) zeros(3,3) J_ba_etaa;...
    ];
  
  % augmented state noise transit matrix
  LL = [...
              L                                  zeros(cov_dem, (win-1)*noise_dem);...
    zeros((win-1)*cov_dem, (win-1)*noise_dem)  zeros((win-1)*cov_dem, noise_dem);...
    ];

  % recover noise covariance from config
  Q = [...
    sigma_n_w zeros(3,3) zeros(3,3) zeros(3,3);...
    zeros(3,3) sigma_n_a zeros(3,3) zeros(3,3);...
    zeros(3,3) zeros(3,3) sigma_eta_w/dt zeros(3,3);...
    zeros(3,3) zeros(3,3) zeros(3,3) sigma_eta_a/dt;...
    ];

  % augmented noise covariance
  QQ = [...
              Q                                  zeros(noise_dem, (win-1)*noise_dem);...
    zeros((win-1)*noise_dem, (win-1)*noise_dem)  zeros((win-1)*noise_dem, noise_dem);...
    ];


  PP_predict = AA*PP*AA' + LL*QQ*LL';
end
