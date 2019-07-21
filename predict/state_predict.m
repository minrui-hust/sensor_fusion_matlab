function [x_predict P_predict] = state_predict(x, P, u, dt, config)
  %Give current state and input, return predict next state

  % config
  g = config.g;
  sigma_n_w = config.sigma_n_w;
  sigma_n_a = config.sigma_n_a;
  sigma_eta_w = config.sigma_eta_w;
  sigma_eta_a = config.sigma_eta_a;

  % recover noise covariance from config
  Q = [...
    sigma_n_w zeros(3,3) zeros(3,3) zeros(3,3);...
    zeros(3,3) sigma_n_a zeros(3,3) zeros(3,3);...
    zeros(3,3) zeros(3,3) sigma_eta_w zeros(3,3);...
    zeros(3,3) zeros(3,3) zeros(3,3) sigma_eta_a;...
    ];%/dt; % yes, it is devide

  % split the state
  p = x(1:3);
  q = x(4:7);
  v = x(8:10);
  bw= x(11:13);
  ba= x(14:16);

  % split the input
  w = u(1:3);
  a = u(4:6);

  % predict the state
  p_predict = p + v*dt;
  q_predict = s3_multi(q, s3_exp((w-bw)*dt));
  v_predict = v + (s3_rotate(q, a-ba) - g)*dt;
  bw_predict = bw;
  ba_predict = ba;

  x_predict = [p_predict; q_predict; v_predict; bw_predict; ba_predict];

  % calc the state transit matrix
  J_p_p = eye(3,3);
  J_p_v = eye(3,3)*dt;
  J_q_q = so3_exp((w-bw)*dt)';
  J_q_bw = -dt*rjac((w-bw)*dt);
  J_v_q = -s3Tso3(q)*so3_hat((a-ba)*dt);
  J_v_v = eye(3,3);
  J_v_ba = -dt*s3Tso3(q); 
  J_bw_bw = eye(3,3);
  J_ba_ba = eye(3,3);

  A = [...
    J_p_p zeros(3,3) J_p_v zeros(3,3) zeros(3,3);...
    zeros(3,3) J_q_q zeros(3,3) J_q_bw zeros(3,3);...
    zeros(3,3) J_v_q J_v_v zeros(3,3) J_v_ba;...
    zeros(3,3) zeros(3,3) zeros(3,3) J_bw_bw zeros(3,3);...
    zeros(3,3) zeros(3,3) zeros(3,3) zeros(3,3) J_ba_ba;...
    ];

  
  % calc the noise transit matrix
  J_q_nw = -dt*rjac((w-bw)*dt);
  J_v_na = -dt*s3Tso3(q);
  J_bw_etaw = eye(3,3)*dt;
  J_ba_etaa = eye(3,3)*dt;

  L = [...
    zeros(3,3)  zeros(3,3) zeros(3,3)  zeros(3,3);...
    J_q_nw zeros(3,3) zeros(3,3) zeros(3,3);...
    zeros(3,3) J_v_na zeros(3,3) zeros(3,3);...
    zeros(3,3) zeros(3,3) J_bw_etaw zeros(3,3);...
    zeros(3,3) zeros(3,3) zeros(3,3) J_ba_etaa;...
    ];

  P_predict = A*P*A' + L*Q*L';
end
