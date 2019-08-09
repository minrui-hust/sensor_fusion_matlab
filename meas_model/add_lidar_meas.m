function [xx_updated, PP_updated] = add_lidar_meas(xx, PP, z, time, history_time, config)
  % find nearest state
  found = false;
  for i=1:size(history_time,1)-1
    if abs(history_time(i)-time)<abs(history_time(i+1)-time)
      found = true;
      break;
    end
  end
  if ~found
    if time>history_time
      xx_updated = xx;
      PP_updated = PP;
      return;
    end
  end

  %i = 1;

  R = config.R;
  win = config.history_win;
  cov_dem = config.cov_dimension;
  state_dem = config.state_dimension;

  % position
  p_pred = xx(1+(i-1)*state_dem:3+(i-1)*state_dem);

  p_meas = z(1:3);

  Hp = zeros(3,cov_dem*win);
  Hp(1:3,1+(i-1)*cov_dem:3+(i-1)*cov_dem) = eye(3,3);

  Rp = R(1:3,1:3);

  [xx, PP] = meas_update(xx, PP, p_meas-p_pred, Hp, Rp, state_dem, cov_dem, win);


  % rotation
  q_pred = xx(4+(i-1)*state_dem:7+(i-1)*state_dem);

  q_meas = z(4:7);

  Hq = zeros(3,cov_dem*win);
  Hq(1:3,4+(i-1)*cov_dem : 6+(i-1)*cov_dem) = eye(3,3);

  Rq = R(4:6,4:6);

  [xx_updated, PP_updated] = meas_update(xx, PP, s3_minus(q_meas, q_pred), Hq, Rq, state_dem, cov_dem, win);
end
