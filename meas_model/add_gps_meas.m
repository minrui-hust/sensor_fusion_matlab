function [x_updated, P_updated] = add_gps_meas(xx, PP, z, time, history_time, config)
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


  % velocity
  v_pred = xx(8+(i-1)*state_dem:10+(i-1)*state_dem);

  v_meas = z(4:6);

  Hv = zeros(3,cov_dem*win);
  Hv(1:3,7+(i-1)*cov_dem : 9+(i-1)*cov_dem) = eye(3,3);

  Rv = R(4:6,4:6);

  [x_updated, P_updated] = meas_update(xx, PP, v_meas-v_pred, Hv, Rv, state_dem, cov_dem, win);
end
