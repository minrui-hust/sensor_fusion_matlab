function x_predict = state_predict(x,u,dt,config)
  %Give current state and input, return predict next state

  % config
  g = config.g;

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
  q_predict = quatmultiply(q', rot2quat((w-bw)'*dt))';
  v_predict = v + (quatrotate(quatconj(q'),(a-ba)')' - g)*dt;
  bw_predict = bw;
  ba_predict = ba;

  x_predict = [p_predict; q_predict; v_predict; bw_predict; ba_predict];
end
